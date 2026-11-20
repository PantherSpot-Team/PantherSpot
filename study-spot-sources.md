# FIU study spot sources

Checked November 19, 2026. Pins mark approximate building locations, not entrances or individual seats. The catalog has six locations: three at MMC and three at BBC.

## Location references

| Spot | Campus | Reference and limits |
| --- | --- | --- |
| Green Library | MMC | [FIU Libraries](https://library.fiu.edu/) lists study areas and quiet study floors. The original building-center coordinate is retained. |
| Graham Center | MMC | [Graham Center spaces](https://dasa.fiu.edu/all-departments/graham-center/panther-spaces/) identifies study spaces including the Piano Lounge / Art Gallery. The app represents the building, not one room. The original coordinate is retained. |
| Hubert Library | BBC | [FIU Libraries](https://library.fiu.edu/) identifies Hubert Library and its learning/support services. The original building-center coordinate is retained. |
| Starbucks at MANGO | MMC | [FIU's 2024 student guide](https://news.fiu.edu/2024/and-were-back-a-students-guide-to-academic-success-and-campus-life-at-fiu) specifically mentions students studying at Starbucks in MANGO. Check current cafe access before visiting. |
| Wolfe University Center | BBC | [FIU's WUC page](https://dasa.fiu.edu/all-departments/wolfe-university-center/) describes the student center and device charging stations by the Panther Square stairway. This is a casual common-area option; the source does not identify a dedicated study room. Seating availability is not verified. |
| Academic One Tutoring Center | BBC | [FIU Mathematics and Statistics help page](https://case.fiu.edu/mathstat/resources/math-help/) identifies Center for Academic Success in-person tutoring at AC1 160 and explains appointment scheduling. This is a tutoring destination, not a promise of open study seating. Check the current schedule and arrange an appointment. |

New coordinates come from FIU's [MMC building data](https://campusmaps.fiu.edu/js/buildings-mmc.js) and [BBC building data](https://campusmaps.fiu.edu/js/buildings-bbc.js), used by the [official campus map](https://campusmaps.fiu.edu/):

| New spot | FIU building | Latitude | Longitude |
| --- | --- | --- | --- |
| Starbucks at MANGO | Management and New Growth Opportunities Building (MANGO) | 25.757311 | -80.376895 |
| Wolfe University Center | WUC | 25.910425 | -80.138915 |
| Academic One Tutoring Center | Academic Center (AC1) | 25.910145 | -80.139688 |

Each spot’s detail screen includes a labeled link to its official FIU reference. The MANGO link is explicitly dated 2024; it is background information, not a current cafe schedule. AC1 links directly to FIU’s tutoring and appointment information.

## Sample information

Noise, Wi-Fi, outlet availability at seats, seating descriptions, and group-study suitability remain sample information for development. The WUC source confirms device charging stations, which does not guarantee a power outlet at a particular seat. No opening hours, live occupancy, available seats, or cafe operating status are promised. The map preview, detail screen, and Settings identify the sample amenities.

Existing UUIDs and coordinates are unchanged. New UUIDs end in `0004` (MANGO), `0005` (WUC), and `0006` (AC1). Campus is stored explicitly rather than inferred from display text.

## Integration with the remaining sprint work

`isGroupStudyFriendly` is explicit on all six records. Green Library, Graham Center, Hubert Library, and WUC are marked group friendly as sample suitability; MANGO and AC1 are not marked group friendly. This does not promise reservable rooms or unrestricted access. AC1’s tutoring service is not evidence of an unrestricted group-study room.

`StudySpotFilters` stores applied selections and tests every active condition. Explore combines that result with `matchesSearch(_:)`. When integrating #16, reuse these types instead of adding separate filter state or parsing seating descriptions. Favorites persistence (#13) stores the same stable IDs locally; all six records keep their existing IDs and coordinates.
