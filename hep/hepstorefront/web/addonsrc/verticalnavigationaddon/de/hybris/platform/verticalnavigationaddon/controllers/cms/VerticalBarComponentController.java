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

package de.hybris.platform.verticalnavigationaddon.controllers.cms;

import de.hybris.platform.addonsupport.controllers.cms.GenericCMSAddOnComponentController;
import de.hybris.platform.cms2.model.contents.components.AbstractCMSComponentModel;
import de.hybris.platform.verticalnavigationaddon.controllers.VerticalnavigationaddonControllerConstants;
import de.hybris.platform.verticalnavigationaddon.model.cms.components.VerticalBarComponentModel;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * Controller for CMS VerticalBarComponent
 */
@Controller("VerticalBarComponentController")
@RequestMapping(value = VerticalnavigationaddonControllerConstants.Actions.Cms.VerticalBarComponent)
public class VerticalBarComponentController extends GenericCMSAddOnComponentController
{
	private static final String CATEGORY_NAVNODE_SUFFIX = "CategoryNavNode";
	private static final String NAVIGATION_NODES = "navNodes";

	@Override
	protected void fillModel(final HttpServletRequest request, final Model model, final AbstractCMSComponentModel component)
	{
		final VerticalBarComponentModel verticalBar = (VerticalBarComponentModel) component;
		verticalBar.getLink().getNavigationNodes().stream().forEach(navNode -> {
			model.addAttribute(NAVIGATION_NODES, navNode.getChildren().stream()
					.filter(subNode -> subNode.getUid().endsWith(CATEGORY_NAVNODE_SUFFIX)).findAny().orElse(null).getChildren());
		});
	}
}