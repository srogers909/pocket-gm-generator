/// Location data for generating birth information
library;

/// US cities with states  
const List<String> usCities = [
  'Atlanta, GA', 'Dallas, TX', 'Houston, TX', 'Chicago, IL', 'Los Angeles, CA',
  'Miami, FL', 'Detroit, MI', 'Philadelphia, PA', 'Phoenix, AZ', 'Charlotte, NC'
];

/// Canadian cities with provinces
const List<String> canadianCities = [
  'Toronto, ON', 'Vancouver, BC', 'Montreal, QC', 'Calgary, AB', 'Ottawa, ON'
];

/// International cities with countries
const List<String> internationalCities = [
  'London, England', 'Sydney, Australia', 'Berlin, Germany', 'Tokyo, Japan', 'Mexico City, Mexico'
];

/// Country data with flags
const Map<String, String> countryFlags = {
  'USA': '🇺🇸',
  'Canada': '🇨🇦', 
  'England': '🇬🇧',
  'Australia': '🇦🇺',
  'Germany': '🇩🇪',
  'Japan': '🇯🇵',
  'Mexico': '🇲🇽'
};
