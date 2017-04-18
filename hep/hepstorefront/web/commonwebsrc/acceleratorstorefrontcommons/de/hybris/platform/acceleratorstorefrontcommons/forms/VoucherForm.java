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
package de.hybris.platform.acceleratorstorefrontcommons.forms;

import de.hybris.platform.acceleratorstorefrontcommons.util.XSSFilterUtil;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;


public class VoucherForm
{
	@NotNull(message = "{text.voucher.apply.invalid.error}")
	@Size(min = 1, max = 255, message = "{text.voucher.apply.invalid.error}")
	String voucherCode;

	public String getVoucherCode()
	{
		return voucherCode;
	}

	public void setVoucherCode(String voucherCode)
	{
		this.voucherCode = XSSFilterUtil.filter(voucherCode);
	}
}
