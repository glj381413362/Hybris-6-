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
package de.hybris.platform.verticalnavigationaddon.controllers;

import de.hybris.platform.verticalnavigationaddon.model.cms.components.VerticalBarComponentModel;


/**
 */
public interface VerticalnavigationaddonControllerConstants
{
	final String ADDON_PREFIX = "addon:/verticalnavigationaddon/";

	/**
	 * Class with action name constants
	 */
	interface Actions
	{
		interface Cms // NOSONAR
		{
			String _Prefix = "/view/"; // NOSONAR
			String _Suffix = "Controller"; // NOSONAR

			/**
			 * Default CMS component controller
			 */
			String VerticalBarComponent = _Prefix + VerticalBarComponentModel._TYPECODE + _Suffix; // NOSONAR
		}
	}
}
