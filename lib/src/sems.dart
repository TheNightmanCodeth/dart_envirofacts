import 'package:dart_json/dart_json.dart';

import 'handlers/envirofacts_api.dart';

/// Provides access functions to all data provided by the EPA's Superfund
/// Enterprise Management System. More info can be found at the model page
/// [here](https://www.epa.gov/enviro/sems-model).
class SEMS {
  /// Default constructor
  SEMS();
  /// Is this active or archived?
  bool active;
  /// Is this facility a federal entity?
  @JsonProperty("FF")
  String ff;
  /// The latitude value of the GPS coordinates
  @JsonProperty("LATITUDE")
  var latitude;
  /// The longitude value of the GPS coordinates
  @JsonProperty("LONGITUDE")
  var longitude;
  /// The description of the code that ids the status of a non-npl site
  @JsonProperty("NON_NPL_STATUS")
  String nonNplStatus;
  /// Is this site on the national priorities list?
  @JsonProperty("NPL")
  String npl;
  /// The name of the city in which this site is located.
  @JsonProperty("SITE_CITY_NAME")
  String cityName;
  /// The name of the county in which this site is located.
  @JsonProperty("SITE_CNTY_NAME")
  String countyName;
  /// The congressional district within which this site is located.
  @JsonProperty("SITE_CONG_DISTRICT")
  String congressionalDistrict;
  /// A code that uniquely identifies this site in the EPA's database.
  @JsonProperty("SITE_EPA_ID")
  String epaID;
  /// A five-digit Federal Information Processing Standard code.
  /// More information can be found [here](https://ofmpub.epa.gov/enviro/EF_METADATA_HTML.ef_metadata_page?p_column_name=SITE_FIPS_CODE&p_table_name=sems_active_sites&p_topic=sems)
  @JsonProperty("SITE_FIPS_CODE")
  int fipsCode;
  /// A unique identifier for this site generated by SEMS at each region.
  @JsonProperty("SITE_ID")
  String siteID;
  /// The legal name of this site
  @JsonProperty("SITE_NAME")
  String siteName;
  /// The state in which this site is located
  @JsonProperty("SITE_STATE")
  String stateName;
  /// The first line of the street address of this site.
  @JsonProperty("SITE_STRT_ADRS1")
  String streetAddress1;
  /// The second line of the street address
  @JsonProperty("SITE_STRT_ADRS2")
  String streetAddress2;
  /// The zipcode of this site
  @JsonProperty("SITE_ZIP_CODE")
  String zipCode;

  /// The default constructor. gets data from API using the EPA ID
  SEMS.fromID(this.epaID) {
    
  }
}

// https://iaspub.epa.gov/enviro/ef_metadata_html.ef_metadata_table?p_table_name=dart_envirofacts_active_sites&p_topic=dart_envirofacts