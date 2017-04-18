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
package de.hybris.platform.notificationaddon.forms;

public class NotificationPreferenceForm
{
	private String emailAddress;
	private String mobileNumber;

	private boolean emailEnabled;
	private boolean smsEnabled;

	public String getEmailAddress()
	{
		return emailAddress;
	}

	public void setEmailAddress(final String emailAddress)
	{
		this.emailAddress = emailAddress;
	}

	public String getMobileNumber()
	{
		return mobileNumber;
	}

	public void setMobileNumber(final String mobileNumber)
	{
		this.mobileNumber = mobileNumber;
	}


	public boolean isEmailEnabled()
	{
		return emailEnabled;
	}

	public void setEmailEnabled(final boolean emailEnabled)
	{
		this.emailEnabled = emailEnabled;
	}

	public boolean isSmsEnabled()
	{
		return smsEnabled;
	}

	public void setSmsEnabled(final boolean smsEnabled)
	{
		this.smsEnabled = smsEnabled;
	}
}
