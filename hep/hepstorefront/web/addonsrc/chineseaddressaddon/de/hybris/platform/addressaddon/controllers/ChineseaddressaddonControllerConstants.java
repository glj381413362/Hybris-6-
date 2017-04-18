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
package de.hybris.platform.addressaddon.controllers;

/**
 */
public interface ChineseaddressaddonControllerConstants
{
	final String ADDON_PREFIX = "addon:/chineseaddressaddon/";

	/**
	 * Class with view name constants
	 */
	interface Views
	{
		interface Fragments
		{
			interface Account
			{
				String CountryAddressForm = ADDON_PREFIX + "fragments/address/countryAddressForm";
			}

		}
	}
}
