var isoCodes = {
'AFGHANISTAN' : 'AF',
'ALAND ISLANDS' : 'AX',
'ALBANIA' : 'AL',
'ALGERIA' : 'DZ',
'AMERICAN SAMOA' : 'AS',
'ANDORRA' : 'AD',
'ANGOLA' : 'AO',
'ANGUILLA' : 'AI',
'ANTARCTICA' : 'AQ',
'ANTIGUA AND BARBUDA' : 'AG',
'ARGENTINA' : 'AR',
'ARMENIA' : 'AM',
'ARUBA' : 'AW',
'AUSTRALIA' : 'AU',
'AUSTRIA' : 'AT',
'AZERBAIJAN' : 'AZ',
'BAHAMAS' : 'BS',
'BAHRAIN' : 'BH',
'BANGLADESH' : 'BD',
'BARBADOS' : 'BB',
'BELARUS' : 'BY',
'BELGIUM' : 'BE',
'BELIZE' : 'BZ',
'BENIN' : 'BJ',
'BERMUDA' : 'BM',
'BHUTAN' : 'BT',
'BOLIVIA' : 'BO',
'BOSNIA AND HERZEGOVINA' : 'BA',
'BOSNIA HERZEGOVINA' : 'BA',
'BOTSWANA' : 'BW',
'BOUVET ISLAND' : 'BV',
'BRAZIL' : 'BR',
'BRITISH INDIAN OCEAN TERRITORY' : 'IO',
'BRUNEI DARUSSALAM' : 'BN',
'BULGARIA' : 'BG',
'BURKINA FASO' : 'BF',
'BURUNDI' : 'BI',
'CAMBODIA' : 'KH',
'CAMEROON' : 'CM',
'CANADA' : 'CA',
'CAPE VERDE' : 'CV',
'CAYMAN ISLANDS' : 'KY',
'CENTRAL AFRICAN REPUBLIC' : 'CF',
'CHAD' : 'TD',
'CHILE' : 'CL',
'CHINA' : 'CN',
'CHRISTMAS ISLAND' : 'CX',
'COCOS (KEELING) ISLANDS' : 'CC',
'COCOS ISLANDS' : 'CC',
'KEELING ISLANDS' : 'CC',
'COLOMBIA' : 'CO',
'COMOROS' : 'KM',
'CONGO' : 'CG',
'CONGO DEMOCRATIC REPUBLIC' : 'CD',
'DEMOCRATIC REPUBLIC OF CONGO' : 'CD',
'COOK ISLANDS' : 'CK',
'COSTA RICA' : 'CR',
'COTE D\'IVOIRE' : 'CI',
'CROATIA' : 'HR',
'CUBA' : 'CU',
'CYPRUS' : 'CY',
'CZECH REPUBLIC' : 'CZ',
'DENMARK' : 'DK',
'DJIBOUTI' : 'DJ',
'DOMINICA' : 'DM',
'DOMINICAN REPUBLIC' : 'DO',
'ECUADOR' : 'EC',
'EGYPT' : 'EG',
'EL SALVADOR' : 'SV',
'EQUATORIAL GUINEA' : 'GQ',
'ERITREA' : 'ER',
'ESTONIA' : 'EE',
'ETHIOPIA' : 'ET',
'FALKLAND ISLANDS (MALVINAS)' : 'FK',
'FALKLAND ISLANDS' : 'FK',
'MALVINAS' : 'FK',
'MALVINAS ISLANDS' : 'FK',
'FAROE ISLANDS' : 'FO',
'FIJI' : 'FJ',
'FINLAND' : 'FI',
'FRANCE' : 'FR',
'FRENCH GUIANA' : 'GF',
'FRENCH POLYNESIA' : 'PF',
'FRENCH SOUTHERN TERRITORIES' : 'TF',
'GABON' : 'GA',
'GAMBIA' : 'GM',
'GEORGIA' : 'GE',
'GERMANY' : 'DE',
'GHANA' : 'GH',
'GIBRALTAR' : 'GI',
'GREECE' : 'GR',
'GREENLAND' : 'GL',
'GRENADA' : 'GD',
'GUADELOUPE' : 'GP',
'GUAM' : 'GU',
'GUATEMALA' : 'GT',
'GUERNSEY' : 'GG',
'GUINEA' : 'GN',
'GUINEA-BISSAU' : 'GW',
'GUINEA BISSAU' : 'GW',
'GUYANA' : 'GY',
'HAITI' : 'HT',
'HEARD ISLAND & MCDONALD ISLANDS' : 'HM',
'HEARD ISLAND' : 'HM',
'MCDONALD ISLANDS' : 'HM',
'HOLY SEE (VATICAN CITY STATE)' : 'VA',
'HOLY SEE' : 'VA',
'VATICAN CITY STATE' : 'VA',
'VATICAN CITY' : 'VA',
'VATICAN' : 'VA',
'HONDURAS' : 'HN',
'HONG KONG' : 'HK',
'HUNGARY' : 'HU',
'ICELAND' : 'IS',
'INDIA' : 'IN',
'INDONESIA' : 'ID',
'IRAN ISLAMIC REPUBLIC OF' : 'IR',
'ISLAMIC REPUBLIC OF IRAN' : 'IR',
'IRAN' : 'IR',
'IRAQ' : 'IQ',
'IRELAND' : 'IE',
'ISLE OF MAN' : 'IM',
'MAN ISLAND' : 'IM',
'ISRAEL' : 'IL',
'ITALY' : 'IT',
'JAMAICA' : 'JM',
'JAPAN' : 'JP',
'JERSEY' : 'JE',
'JORDAN' : 'JO',
'KAZAKHSTAN' : 'KZ',
'KENYA' : 'KE',
'KIRIBATI' : 'KI',
'KOREA' : 'KR',
'KUWAIT' : 'KW',
'KYRGYZSTAN' : 'KG',
'LAO PEOPLE\'S DEMOCRATIC REPUBLIC' : 'LA',
'LAOS' : 'LA',
'LAOS PEOPLE\'S DEMOCRATIC REPUBLIC' : 'LA',
'PEOPLE\'S DEMOCRATIC REPUBLIC OF LAOS' : 'LA',
'LATVIA' : 'LV',
'LEBANON' : 'LB',
'LESOTHO' : 'LS',
'LIBERIA' : 'LR',
'LIBYAN ARAB JAMAHIRIYA' : 'LY',
'LIBYA' : 'LY',
'LIECHTENSTEIN' : 'LI',
'LITHUANIA' : 'LT',
'LUXEMBOURG' : 'LU',
'MACAO' : 'MO',
'MACEDONIA' : 'MK',
'MADAGASCAR' : 'MG',
'MALAWI' : 'MW',
'MALAYSIA' : 'MY',
'MALDIVES' : 'MV',
'MALI' : 'ML',
'MALTA' : 'MT',
'MARSHALL ISLANDS' : 'MH',
'MARTINIQUE' : 'MQ',
'MAURITANIA' : 'MR',
'MAURITIUS' : 'MU',
'MAYOTTE' : 'YT',
'MEXICO' : 'MX',
'MICRONESIA FEDERATED STATES OF' : 'FM',
'FEDERATED STATES OF MICRONESIA' : 'FM',
'MICRONESIA' : 'FM',
'MOLDOVA' : 'MD',
'MONACO' : 'MC',
'MONGOLIA' : 'MN',
'MONTENEGRO' : 'ME',
'MONTSERRAT' : 'MS',
'MOROCCO' : 'MA',
'MOZAMBIQUE' : 'MZ',
'MYANMAR' : 'MM',
'NAMIBIA' : 'NA',
'NAURU' : 'NR',
'NEPAL' : 'NP',
'NETHERLANDS' : 'NL',
'NETHERLANDS ANTILLES' : 'AN',
'NEW CALEDONIA' : 'NC',
'NEW ZEALAND' : 'NZ',
'NICARAGUA' : 'NI',
'NIGER' : 'NE',
'NIGERIA' : 'NG',
'NIUE' : 'NU',
'NORFOLK ISLAND' : 'NF',
'NORTHERN MARIANA ISLANDS' : 'MP',
'NORWAY' : 'NO',
'OMAN' : 'OM',
'PAKISTAN' : 'PK',
'PALAU' : 'PW',
'PALESTINIAN TERRITORY OCCUPIED' : 'PS',
'PALESTINA' : 'PS',
'PALESTINE' : 'PS',
'PALESTINIAN TERRITORY' : 'PS',
'STATE OF PALESTINA' : 'PS',
'STATE OF PALESTINE' : 'PS',
'PALESTINIAN STATE' : 'PS',
'PALESTINIAN OCCUPIED TERRITORY' : 'PS',
'PANAMA' : 'PA',
'PAPUA NEW GUINEA' : 'PG',
'PARAGUAY' : 'PY',
'PERU' : 'PE',
'PHILIPPINES' : 'PH',
'PITCAIRN' : 'PN',
'POLAND' : 'PL',
'PORTUGAL' : 'PT',
'PUERTO RICO' : 'PR',
'QATAR' : 'QA',
'REUNION' : 'RE',
'ROMANIA' : 'RO',
'RUSSIAN FEDERATION' : 'RU',
'RUSSIA' : 'RU',
'RWANDA' : 'RW',
'SAINT BARTHELEMY' : 'BL',
'SAINT HELENA' : 'SH',
'SAINT KITTS AND NEVIS' : 'KN',
'SAINT LUCIA' : 'LC',
'SAINT MARTIN' : 'MF',
'SAINT PIERRE AND MIQUELON' : 'PM',
'SAINT VINCENT AND GRENADINES' : 'VC',
'SAMOA' : 'WS',
'SAN MARINO' : 'SM',
'SAO TOME AND PRINCIPE' : 'ST',
'SAUDI ARABIA' : 'SA',
'SENEGAL' : 'SN',
'SERBIA' : 'RS',
'SEYCHELLES' : 'SC',
'SIERRA LEONE' : 'SL',
'SINGAPORE' : 'SG',
'SLOVAKIA' : 'SK',
'SLOVENIA' : 'SI',
'SOLOMON ISLANDS' : 'SB',
'SOMALIA' : 'SO',
'SOUTH AFRICA' : 'ZA',
'SOUTH GEORGIA AND SANDWICH ISL.' : 'GS',
'SOUTH GEORGIA AND SANDWICH ISLAND' : 'GS',
'SOUTH GEORGIA AND SANDWICH ISLANDS' : 'GS',
'SOUTH GEORGIA' : 'GS',
'SPAIN' : 'ES',
'SRI LANKA' : 'LK',
'SUDAN' : 'SD',
'SURINAME' : 'SR',
'SVALBARD AND JAN MAYEN' : 'SJ',
'SVALBARD' : 'SJ',
'SWAZILAND' : 'SZ',
'SWEDEN' : 'SE',
'SWITZERLAND' : 'CH',
'SYRIAN ARAB REPUBLIC' : 'SY',
'SYRIA' : 'SY',
'TAIWAN' : 'TW',
'TAJIKISTAN' : 'TJ',
'TANZANIA' : 'TZ',
'THAILAND' : 'TH',
'TIMOR-LESTE' : 'TL',
'TIMOR LESTE' : 'TL',
'TOGO' : 'TG',
'TOKELAU' : 'TK',
'TONGA' : 'TO',
'TRINIDAD AND TOBAGO' : 'TT',
'TUNISIA' : 'TN',
'TURKEY' : 'TR',
'TURKMENISTAN' : 'TM',
'TURKS AND CAICOS ISLANDS' : 'TC',
'TUVALU' : 'TV',
'UGANDA' : 'UG',
'UKRAINE' : 'UA',
'UNITED ARAB EMIRATES' : 'AE',
'ARAB EMIRATES' : 'AE',
'UNITED KINGDOM' : 'GB',
'GREAT BRITAIN' : 'GB',
'ENGLAND' : 'GB',
'SCOTLAND' : 'GB',
'WALES' : 'GB',
'UNITED KINGDOM OF BRITAIN AND NORTHERN IRELAND' : 'GB',
'NORTHERN IRELAND' : 'GB',
'UNITED STATES' : 'US',
'UNITED STATES OF AMERICA' : 'US',
'USA' : 'US',
'UNITED STATES OUTLYING ISLANDS' : 'UM',
'URUGUAY' : 'UY',
'UZBEKISTAN' : 'UZ',
'VANUATU' : 'VU',
'VENEZUELA' : 'VE',
'VIET NAM' : 'VN',
'VIETNAM' : 'VN',
'VIRGIN ISLANDS BRITISH' : 'VG',
'VIRGIN ISLANDS U.S.' : 'VI',
'WALLIS AND FUTUNA' : 'WF',
'WESTERN SAHARA' : 'EH',
'YEMEN' : 'YE',
'ZAMBIA' : 'ZM',
'ZIMBABWE' : 'ZW'
};