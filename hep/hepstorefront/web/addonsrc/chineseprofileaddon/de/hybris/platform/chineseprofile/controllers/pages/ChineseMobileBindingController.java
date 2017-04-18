/*
 * [y] hybris Platform
 *
 * Copyright (c) 2017 SAP SE or an SAP affiliate company.  All rights reserved.
 *
 * This software is the confidential and proprietary information of SAP
 * ("Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the
 * license agreement you entered into with SAP.
 */
package de.hybris.platform.chineseprofile.controllers.pages;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import de.hybris.platform.acceleratorstorefrontcommons.annotations.RequireHardLogIn;
import de.hybris.platform.acceleratorstorefrontcommons.breadcrumb.ResourceBreadcrumbBuilder;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.ThirdPartyConstants;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractPageController;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.chineseprofile.constants.WebConstants;
import de.hybris.platform.chineseprofile.controllers.ControllerConstants;
import de.hybris.platform.chineseprofile.forms.VerificationCodeForm;
import de.hybris.platform.chineseprofilefacades.customer.CustomerFacade;
import de.hybris.platform.chineseprofileservices.data.VerificationData;
import de.hybris.platform.commercefacades.user.data.CustomerData;

import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;

/**
 * Handle customer's mobile number binding.
 */
@Controller
@Scope("tenant")
@RequestMapping(value = "/mobile")
public class ChineseMobileBindingController extends AbstractPageController
{

	private static final String UPDATE_PROFILE_CMS_PAGE = "update-profile";
	private static final String BREADCRUMBS_ATTR = "breadcrumbs";
	private static final String TEXT_ACCOUNT_PROFILE = "text.account.profile";
	private static final String FORM_GLOBAL_ERROR = "form.global.error";
	private static final String UPDATE_PROFILE_URL = "/my-account/update-profile";
	private static final String REDIRECT_PREFIX = "redirect:";
	private static final String HOME_PAGE = "/";


	@Resource(name = "chineseCustomerFacade")
	private CustomerFacade chineseCustomerFacade;

	@Resource(name = "accountBreadcrumbBuilder")
	private ResourceBreadcrumbBuilder accountBreadcrumbBuilder;

	@Resource(name = "verifyMobileNumberValidator")
	private Validator verifyMobileNumberValidator;

	final String[] DISALLOWED_FIELDS = new String[]{};
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    binder.setDisallowedFields(DISALLOWED_FIELDS);
	}

	@RequireHardLogIn
	@RequestMapping(value = "/binding", method = RequestMethod.POST)
	public String bindMobileNumber(final Model model, final VerificationCodeForm form) throws CMSItemNotFoundException
	{
		populateAttributes(model);
		return ControllerConstants.Views.Pages.Account.ChineseMobileProfileBindingPage;
	}

	@RequireHardLogIn
	@RequestMapping(value = "/bind", method = RequestMethod.POST)
	public String bindMobileNumber(final Model model, final VerificationCodeForm form, final BindingResult bindingResult,
			final RedirectAttributes redirectModel) throws CMSItemNotFoundException
	{
		verifyMobileNumberValidator.validate(form, bindingResult);
		if (bindingResult.hasErrors())
		{
			model.addAttribute(form);
			populateAttributes(model);
			GlobalMessages.addErrorMessage(model, FORM_GLOBAL_ERROR);
			return ControllerConstants.Views.Pages.Account.ChineseMobileProfileBindingPage;
		}

		final VerificationData verificationData = new VerificationData();
		verificationData.setMobileNumber(form.getMobileNumber());
		chineseCustomerFacade.saveMobileNumber(verificationData);
		chineseCustomerFacade.removeVerificationCodeFromSession(WebConstants.VERIFICATION_CODE_FOR_MOBILE_BINDING);

		GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.CONF_MESSAGES_HOLDER,
				"mobile.binding.confirmation.message.title");

		return REDIRECT_PREFIX + UPDATE_PROFILE_URL;
	}

	@RequireHardLogIn
	@RequestMapping(value = "/register/bind", method = RequestMethod.GET)
	public String bindMobileAfterRegister(final Model model, final VerificationCodeForm form)
			throws CMSItemNotFoundException
	{
		populateAttributes(model);
		return ControllerConstants.Views.Pages.Account.ChineseMobileRegisterBindingPage;
	}

	@RequireHardLogIn
	@RequestMapping(value = "/register/bind", method = RequestMethod.POST)
	public String bindMobileAfterRegister(final Model model, final VerificationCodeForm form, final BindingResult bindingResult,
			final RedirectAttributes redirectModel) throws CMSItemNotFoundException
	{

		verifyMobileNumberValidator.validate(form, bindingResult);
		if (bindingResult.hasErrors())
		{
			model.addAttribute(form);
			populateAttributes(model);
			GlobalMessages.addErrorMessage(model, FORM_GLOBAL_ERROR);
			return ControllerConstants.Views.Pages.Account.ChineseMobileRegisterBindingPage;
		}

		final VerificationData verificationData = new VerificationData();
		verificationData.setMobileNumber(form.getMobileNumber());
		chineseCustomerFacade.saveMobileNumber(verificationData);
		chineseCustomerFacade.removeVerificationCodeFromSession(WebConstants.VERIFICATION_CODE_FOR_MOBILE_BINDING);

		GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.CONF_MESSAGES_HOLDER,
				"mobile.binding.confirmation.message.title");

		return REDIRECT_PREFIX + HOME_PAGE;
	}

	@RequireHardLogIn
	@RequestMapping(value = "/unbind", method = RequestMethod.GET)
	public String verifyMobile(final Model model, final VerificationCodeForm verificationCodeForm) throws CMSItemNotFoundException
	{
		final CustomerData customerData = chineseCustomerFacade.getCurrentCustomer();
		verificationCodeForm.setMobileNumber(customerData.getMobileNumber());

		populateAttributes(model);

		return ControllerConstants.Views.Pages.Account.ChineseMobileUnbindingPage;
	}

	@RequireHardLogIn
	@RequestMapping(value = "/unbind", method = RequestMethod.POST)
	public String verifyMobile(final Model model, final VerificationCodeForm verificationCodeForm,
			final BindingResult bindingResult, final RedirectAttributes redirectModel) throws CMSItemNotFoundException
	{
		verifyMobileNumberValidator.validate(verificationCodeForm, bindingResult);
		if (bindingResult.hasErrors())
		{
			model.addAttribute(verificationCodeForm);
			populateAttributes(model);
			GlobalMessages.addErrorMessage(model, FORM_GLOBAL_ERROR);
			return ControllerConstants.Views.Pages.Account.ChineseMobileUnbindingPage;
		}

		chineseCustomerFacade.saveMobileNumber(new VerificationData());
		chineseCustomerFacade.removeVerificationCodeFromSession(WebConstants.VERIFICATION_CODE_FOR_MOBILE_BINDING);

		GlobalMessages.addFlashMessage(redirectModel, GlobalMessages.CONF_MESSAGES_HOLDER,
				"mobile.unbinding.confirmation.message.title");

		return REDIRECT_PREFIX + UPDATE_PROFILE_URL;
	}

	/**
	 * Populate some common data.
	 */
	protected void populateAttributes(final Model model) throws CMSItemNotFoundException
	{
		storeCmsPageInModel(model, getContentPageForLabelOrId(UPDATE_PROFILE_CMS_PAGE));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(UPDATE_PROFILE_CMS_PAGE));
		model.addAttribute(BREADCRUMBS_ATTR, accountBreadcrumbBuilder.getBreadcrumbs(TEXT_ACCOUNT_PROFILE));
		model.addAttribute(ThirdPartyConstants.SeoRobots.META_ROBOTS, ThirdPartyConstants.SeoRobots.NOINDEX_NOFOLLOW);
	}

}
