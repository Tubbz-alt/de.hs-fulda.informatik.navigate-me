//
//  GoogleMapViewController.swift
//  NavigateMe
//
//  Created by mahbub on 2/26/18.
//  Copyright © 2018 Fulda University Of Applied Sciences. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

class GoogleMapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, EngineDelegate {

    let navigation = NEngine()

    let floorStringValues = ["Floor: 0", "Floor: 1", "Floor: 3"]
    let floorIntValues = [0, 1, 3]
    
    let universityBlock1Vertexs = [
        "46(E).1" : CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977),
        "a" : CLLocationCoordinate2D(latitude: 50.564930841824669, longitude: 9.6854161843657494),
        "b" : CLLocationCoordinate2D(latitude: 50.564727669415412, longitude: 9.6859190985560417),
        "c" : CLLocationCoordinate2D(latitude: 50.564386278163909, longitude: 9.6856210380792618),
        "d" : CLLocationCoordinate2D(latitude: 50.564578803540599, longitude: 9.6850886195898056),
        "e" : CLLocationCoordinate2D(latitude: 50.564451873181468, longitude: 9.6849659085273743),
        "f" : CLLocationCoordinate2D(latitude: 50.564402676926854, longitude: 9.684707410633564),
        "g" : CLLocationCoordinate2D(latitude: 50.564216539983569, longitude: 9.6845464780926704),
        "h" : CLLocationCoordinate2D(latitude: 50.564090034593292, longitude: 9.6853632107377052),
        "i" : CLLocationCoordinate2D(latitude: 50.563978862909359, longitude: 9.6852653101086617)
    ]

    // tuple(0 -> raum coordinate, 1 -> dictionary where key -> gebaude entrance coordinate, value -> steps from entrance to raum)
    let raumCoordinates = [
        265 : (
            CLLocationCoordinate2D(latitude: 50.565298849995976, longitude: 9.6852341294288635), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565083540008501, longitude: 9.6855596825480461),
                    CLLocationCoordinate2D(latitude: 50.565201098105803, longitude: 9.6852562576532364)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564978333781454, longitude: 9.6858382970094681),
                    CLLocationCoordinate2D(latitude: 50.565024973817962, longitude: 9.6858781948685646),
                    CLLocationCoordinate2D(latitude: 50.565109096141533, longitude: 9.6856481954455376),
                    CLLocationCoordinate2D(latitude: 50.56506415993168, longitude: 9.685608297586441),
                    CLLocationCoordinate2D(latitude: 50.565201098105803, longitude: 9.6852562576532364)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.565201098105803, longitude: 9.6852562576532364)
                ]
            ]
        ),
        268 : (
            CLLocationCoordinate2D(latitude: 50.565215579880096, longitude: 9.6854306012392044), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565081197362275, longitude: 9.6855583414435387),
                    CLLocationCoordinate2D(latitude: 50.565164041780704, longitude: 9.6853310242295265),
                    CLLocationCoordinate2D(latitude: 50.565178523566374, longitude: 9.6853487938642502)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564978333781454, longitude: 9.6858382970094681),
                    CLLocationCoordinate2D(latitude: 50.565024973817962, longitude: 9.6858781948685646),
                    CLLocationCoordinate2D(latitude: 50.565109096141533, longitude: 9.6856481954455376),
                    CLLocationCoordinate2D(latitude: 50.56506415993168, longitude: 9.685608297586441),
                    CLLocationCoordinate2D(latitude: 50.565164041780704, longitude: 9.6853310242295265),
                    CLLocationCoordinate2D(latitude: 50.565178523566374, longitude: 9.6853487938642502)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.565164041780704, longitude: 9.6853310242295265),
                    CLLocationCoordinate2D(latitude: 50.565178523566374, longitude: 9.6853487938642502)
                ]
            ]
        ),
        285 : (
            CLLocationCoordinate2D(latitude: 50.56502092742393, longitude: 9.68596201390028), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565081197362275, longitude: 9.6855583414435387),
                    CLLocationCoordinate2D(latitude: 50.56506415993168, longitude: 9.685608297586441),
                    CLLocationCoordinate2D(latitude: 50.565109096141533, longitude: 9.6856481954455376),
                    CLLocationCoordinate2D(latitude: 50.565024973817962, longitude: 9.6858781948685646),
                    CLLocationCoordinate2D(latitude: 50.565001547321366, longitude: 9.6858567371964455),
                    CLLocationCoordinate2D(latitude: 50.564993454528931, longitude: 9.6858735010027885)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564978333781454, longitude: 9.6858382970094681),
                    CLLocationCoordinate2D(latitude: 50.565001547321366, longitude: 9.6858567371964455),
                    CLLocationCoordinate2D(latitude: 50.564993454528931, longitude: 9.6858735010027885)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.56506415993168, longitude: 9.685608297586441),
                    CLLocationCoordinate2D(latitude: 50.565109096141533, longitude: 9.6856481954455376),
                    CLLocationCoordinate2D(latitude: 50.565024973817962, longitude: 9.6858781948685646),
                    CLLocationCoordinate2D(latitude: 50.565001547321366, longitude: 9.6858567371964455),
                    CLLocationCoordinate2D(latitude: 50.564993454528931, longitude: 9.6858735010027885)
                ]
            ]
        ),
        288 : (
            CLLocationCoordinate2D(latitude: 50.564916359962844, longitude: 9.6858654543757439), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565081197362275, longitude: 9.6855583414435387),
                    CLLocationCoordinate2D(latitude: 50.56506415993168, longitude: 9.685608297586441),
                    CLLocationCoordinate2D(latitude: 50.565015603220708, longitude: 9.6855640411376953),
                    CLLocationCoordinate2D(latitude: 50.564932971509862, longitude: 9.6857953816652298),
                    CLLocationCoordinate2D(latitude: 50.564944471808182, longitude: 9.6858061105012894),
                    CLLocationCoordinate2D(latitude: 50.564938082753905, longitude: 9.685823880136013)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564978333781454, longitude: 9.6858382970094681),
                    CLLocationCoordinate2D(latitude: 50.564944471808182, longitude: 9.6858061105012894),
                    CLLocationCoordinate2D(latitude: 50.564938082753905, longitude: 9.685823880136013)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.56506415993168, longitude: 9.685608297586441),
                    CLLocationCoordinate2D(latitude: 50.565015603220708, longitude: 9.6855640411376953),
                    CLLocationCoordinate2D(latitude: 50.564932971509862, longitude: 9.6857953816652298),
                    CLLocationCoordinate2D(latitude: 50.564944471808182, longitude: 9.6858061105012894),
                    CLLocationCoordinate2D(latitude: 50.564938082753905, longitude: 9.685823880136013)
                ]
            ]
        ),
        291 : (
            CLLocationCoordinate2D(latitude: 50.564991324846488, longitude: 9.6857001632452011), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565081197362275, longitude: 9.6855583414435387),
                    CLLocationCoordinate2D(latitude: 50.56506415993168, longitude: 9.685608297586441),
                    CLLocationCoordinate2D(latitude: 50.565015603220708, longitude: 9.6855640411376953),
                    CLLocationCoordinate2D(latitude: 50.564990685941723, longitude: 9.6856327727437019),
                    CLLocationCoordinate2D(latitude: 50.565001121384967, longitude: 9.6856391429901123)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564978333781454, longitude: 9.6858382970094681),
                    CLLocationCoordinate2D(latitude: 50.564932971509862, longitude: 9.6857953816652298),
                    CLLocationCoordinate2D(latitude: 50.564990685941723, longitude: 9.6856327727437019),
                    CLLocationCoordinate2D(latitude: 50.565001121384967, longitude: 9.6856391429901123)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.56506415993168, longitude: 9.685608297586441),
                    CLLocationCoordinate2D(latitude: 50.565015603220708, longitude: 9.6855640411376953),
                    CLLocationCoordinate2D(latitude: 50.564990685941723, longitude: 9.6856327727437019),
                    CLLocationCoordinate2D(latitude: 50.565001121384967, longitude: 9.6856391429901123)
                ]
            ]
        ),
        292 : (
            CLLocationCoordinate2D(latitude: 50.565034344413327, longitude: 9.6857383847236633), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565081197362275, longitude: 9.6855583414435387),
                    CLLocationCoordinate2D(latitude: 50.56506415993168, longitude: 9.685608297586441),
                    CLLocationCoordinate2D(latitude: 50.565109096141533, longitude: 9.6856481954455376),
                    CLLocationCoordinate2D(latitude: 50.565084178911988, longitude: 9.6857169270515442),
                    CLLocationCoordinate2D(latitude: 50.565075447230136, longitude: 9.6857068687677383)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564978333781454, longitude: 9.6858382970094681),
                    CLLocationCoordinate2D(latitude: 50.565024973817962, longitude: 9.6858781948685646),
                    CLLocationCoordinate2D(latitude: 50.565084178911988, longitude: 9.6857169270515442),
                    CLLocationCoordinate2D(latitude: 50.565075447230136, longitude: 9.6857068687677383)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.56506415993168, longitude: 9.685608297586441),
                    CLLocationCoordinate2D(latitude: 50.565109096141533, longitude: 9.6856481954455376),
                    CLLocationCoordinate2D(latitude: 50.565084178911988, longitude: 9.6857169270515442),
                    CLLocationCoordinate2D(latitude: 50.565075447230136, longitude: 9.6857068687677383)
                ]
            ]
        ),
        266 : (
            CLLocationCoordinate2D(latitude: 50.565298849995976, longitude: 9.6852341294288635), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565046696558944, longitude: 9.6853970736265182),
                    CLLocationCoordinate2D(latitude: 50.565087160461523, longitude: 9.6854366362094879),
                    CLLocationCoordinate2D(latitude: 50.565096956980085, longitude: 9.6854138374328613),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854010969400406),
                    CLLocationCoordinate2D(latitude: 50.565062882124145, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.565066928514582, longitude: 9.6854560822248459),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854661405086517),
                    CLLocationCoordinate2D(latitude: 50.565110373947853, longitude: 9.6854926273226738),
                    CLLocationCoordinate2D(latitude: 50.565201311073096, longitude: 9.6852529048919678)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564981954242548, longitude: 9.6858356148004532),
                    CLLocationCoordinate2D(latitude: 50.565014112443713, longitude: 9.6858644485473633),
                    CLLocationCoordinate2D(latitude: 50.565091845753265, longitude: 9.6856585890054703),
                    CLLocationCoordinate2D(latitude: 50.56506032650897, longitude: 9.6856200322508812),
                    CLLocationCoordinate2D(latitude: 50.565201311073096, longitude: 9.6852529048919678)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.565201311073096, longitude: 9.6852529048919678)
                ]
            ]
        ),
        362 : (
            CLLocationCoordinate2D(latitude: 50.565114633301896, longitude: 9.6853353828191757), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565046696558944, longitude: 9.6853970736265182),
                    CLLocationCoordinate2D(latitude: 50.565087160461523, longitude: 9.6854366362094879),
                    CLLocationCoordinate2D(latitude: 50.565096956980085, longitude: 9.6854138374328613),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854010969400406),
                    CLLocationCoordinate2D(latitude: 50.565062882124145, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.565066928514582, longitude: 9.6854560822248459),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854661405086517),
                    CLLocationCoordinate2D(latitude: 50.565107818335221, longitude: 9.6854909509420395),
                    CLLocationCoordinate2D(latitude: 50.565136356001531, longitude: 9.6854101493954659),
                    CLLocationCoordinate2D(latitude: 50.565122513105869, longitude: 9.68540009111166)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564981954242548, longitude: 9.6858356148004532),
                    CLLocationCoordinate2D(latitude: 50.565014112443713, longitude: 9.6858644485473633),
                    CLLocationCoordinate2D(latitude: 50.565091845753265, longitude: 9.6856585890054703),
                    CLLocationCoordinate2D(latitude: 50.56506032650897, longitude: 9.6856200322508812),
                    CLLocationCoordinate2D(latitude: 50.565136356001531, longitude: 9.6854101493954659),
                    CLLocationCoordinate2D(latitude: 50.565122513105869, longitude: 9.68540009111166)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.565136356001531, longitude: 9.6854101493954659),
                    CLLocationCoordinate2D(latitude: 50.565122513105869, longitude: 9.68540009111166)
                ]
            ]
        ),
        364 : (
            CLLocationCoordinate2D(latitude: 50.565175542022637, longitude: 9.6851184591650963), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565046696558944, longitude: 9.6853970736265182),
                    CLLocationCoordinate2D(latitude: 50.565087160461523, longitude: 9.6854366362094879),
                    CLLocationCoordinate2D(latitude: 50.565096956980085, longitude: 9.6854138374328613),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854010969400406),
                    CLLocationCoordinate2D(latitude: 50.565062882124145, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.565066928514582, longitude: 9.6854560822248459),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854661405086517),
                    CLLocationCoordinate2D(latitude: 50.565104836787008, longitude: 9.6854922920465469),
                    CLLocationCoordinate2D(latitude: 50.565191301608898, longitude: 9.685240164399147)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564981954242548, longitude: 9.6858356148004532),
                    CLLocationCoordinate2D(latitude: 50.565014112443713, longitude: 9.6858644485473633),
                    CLLocationCoordinate2D(latitude: 50.565091845753265, longitude: 9.6856585890054703),
                    CLLocationCoordinate2D(latitude: 50.56506032650897, longitude: 9.6856200322508812),
                    CLLocationCoordinate2D(latitude: 50.565191301608898, longitude: 9.685240164399147)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.565191301608898, longitude: 9.685240164399147)
                ]
            ]
        ),
        369 : (
            CLLocationCoordinate2D(latitude: 50.565220052191847, longitude: 9.6854326128959656), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565046696558944, longitude: 9.6853970736265182),
                    CLLocationCoordinate2D(latitude: 50.565087160461523, longitude: 9.6854366362094879),
                    CLLocationCoordinate2D(latitude: 50.565096956980085, longitude: 9.6854138374328613),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854010969400406),
                    CLLocationCoordinate2D(latitude: 50.565062882124145, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.565066928514582, longitude: 9.6854560822248459),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854661405086517),
                    CLLocationCoordinate2D(latitude: 50.565108670206108, longitude: 9.6854932978749275),
                    CLLocationCoordinate2D(latitude: 50.565169365967108, longitude: 9.6853350475430489),
                    CLLocationCoordinate2D(latitude: 50.565179162468588, longitude: 9.6853461116552353)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564981954242548, longitude: 9.6858356148004532),
                    CLLocationCoordinate2D(latitude: 50.565014112443713, longitude: 9.6858644485473633),
                    CLLocationCoordinate2D(latitude: 50.565091845753265, longitude: 9.6856585890054703),
                    CLLocationCoordinate2D(latitude: 50.56506032650897, longitude: 9.6856200322508812),
                    CLLocationCoordinate2D(latitude: 50.565169365967108, longitude: 9.6853350475430489),
                    CLLocationCoordinate2D(latitude: 50.565179162468588, longitude: 9.6853461116552353)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.565169365967108, longitude: 9.6853350475430489),
                    CLLocationCoordinate2D(latitude: 50.565179162468588, longitude: 9.6853461116552353)
                ]
            ]
        ),
        378 : (
            CLLocationCoordinate2D(latitude: 50.565155097146139, longitude: 9.6856230497360229), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565046696558944, longitude: 9.6853970736265182),
                    CLLocationCoordinate2D(latitude: 50.565087160461523, longitude: 9.6854366362094879),
                    CLLocationCoordinate2D(latitude: 50.565096956980085, longitude: 9.6854138374328613),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854010969400406),
                    CLLocationCoordinate2D(latitude: 50.565062882124145, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.565066928514582, longitude: 9.6854560822248459),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854661405086517),
                    CLLocationCoordinate2D(latitude: 50.565107818335221, longitude: 9.6854909509420395),
                    CLLocationCoordinate2D(latitude: 50.565067780386208, longitude: 9.6855979040265083),
                    CLLocationCoordinate2D(latitude: 50.565083965944162, longitude: 9.6856119856238365)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564981954242548, longitude: 9.6858356148004532),
                    CLLocationCoordinate2D(latitude: 50.565014112443713, longitude: 9.6858644485473633),
                    CLLocationCoordinate2D(latitude: 50.565091845753265, longitude: 9.6856585890054703),
                    CLLocationCoordinate2D(latitude: 50.56506032650897, longitude: 9.6856200322508812),
                    CLLocationCoordinate2D(latitude: 50.565067780386208, longitude: 9.6855979040265083),
                    CLLocationCoordinate2D(latitude: 50.565083965944162, longitude: 9.6856119856238365)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.565067780386208, longitude: 9.6855979040265083),
                    CLLocationCoordinate2D(latitude: 50.565083965944162, longitude: 9.6856119856238365)
                ]
            ]
        ),
        386 : (
            CLLocationCoordinate2D(latitude: 50.565025612722266, longitude: 9.6859667077660561), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565046696558944, longitude: 9.6853970736265182),
                    CLLocationCoordinate2D(latitude: 50.565087160461523, longitude: 9.6854366362094879),
                    CLLocationCoordinate2D(latitude: 50.565096956980085, longitude: 9.6854138374328613),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854010969400406),
                    CLLocationCoordinate2D(latitude: 50.565062882124145, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.565066928514582, longitude: 9.6854560822248459),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854661405086517),
                    CLLocationCoordinate2D(latitude: 50.565107818335221, longitude: 9.6854909509420395),
                    CLLocationCoordinate2D(latitude: 50.56506032650897, longitude: 9.6856200322508812),
                    CLLocationCoordinate2D(latitude: 50.565091845753265, longitude: 9.6856585890054703),
                    CLLocationCoordinate2D(latitude: 50.565014112443713, longitude: 9.6858644485473633),
                    CLLocationCoordinate2D(latitude: 50.565000908416756, longitude: 9.6858543902635574),
                    CLLocationCoordinate2D(latitude: 50.564991324846488, longitude: 9.6858785301446915)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564981954242548, longitude: 9.6858356148004532),
                    CLLocationCoordinate2D(latitude: 50.565000908416756, longitude: 9.6858543902635574),
                    CLLocationCoordinate2D(latitude: 50.564991324846488, longitude: 9.6858785301446915)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.56506032650897, longitude: 9.6856200322508812),
                    CLLocationCoordinate2D(latitude: 50.565091845753265, longitude: 9.6856585890054703),
                    CLLocationCoordinate2D(latitude: 50.565014112443713, longitude: 9.6858644485473633),
                    CLLocationCoordinate2D(latitude: 50.565000908416756, longitude: 9.6858543902635574),
                    CLLocationCoordinate2D(latitude: 50.564991324846488, longitude: 9.6858785301446915)
                ]
            ]
        ),
        388 : (
            CLLocationCoordinate2D(latitude: 50.564925943548381, longitude: 9.6858768537640572), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565046696558944, longitude: 9.6853970736265182),
                    CLLocationCoordinate2D(latitude: 50.565087160461523, longitude: 9.6854366362094879),
                    CLLocationCoordinate2D(latitude: 50.565096956980085, longitude: 9.6854138374328613),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854010969400406),
                    CLLocationCoordinate2D(latitude: 50.565062882124145, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.565066928514582, longitude: 9.6854560822248459),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854661405086517),
                    CLLocationCoordinate2D(latitude: 50.565107818335221, longitude: 9.6854909509420395),
                    CLLocationCoordinate2D(latitude: 50.56506032650897, longitude: 9.6856200322508812),
                    CLLocationCoordinate2D(latitude: 50.565091845753265, longitude: 9.6856585890054703),
                    CLLocationCoordinate2D(latitude: 50.565014112443713, longitude: 9.6858644485473633),
                    CLLocationCoordinate2D(latitude: 50.564969815048322, longitude: 9.6858128160238266)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564981954242548, longitude: 9.6858356148004532),
                    CLLocationCoordinate2D(latitude: 50.564969815048322, longitude: 9.6858128160238266)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.56506032650897, longitude: 9.6856200322508812),
                    CLLocationCoordinate2D(latitude: 50.565091845753265, longitude: 9.6856585890054703),
                    CLLocationCoordinate2D(latitude: 50.565014112443713, longitude: 9.6858644485473633),
                    CLLocationCoordinate2D(latitude: 50.564969815048322, longitude: 9.6858128160238266)
                ]
            ]
        ),
        390 : (
            CLLocationCoordinate2D(latitude: 50.564996223115983, longitude: 9.6857068687677383), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565046696558944, longitude: 9.6853970736265182),
                    CLLocationCoordinate2D(latitude: 50.565087160461523, longitude: 9.6854366362094879),
                    CLLocationCoordinate2D(latitude: 50.565096956980085, longitude: 9.6854138374328613),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854010969400406),
                    CLLocationCoordinate2D(latitude: 50.565062882124145, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.565066928514582, longitude: 9.6854560822248459),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854661405086517),
                    CLLocationCoordinate2D(latitude: 50.565107818335221, longitude: 9.6854909509420395),
                    CLLocationCoordinate2D(latitude: 50.56506032650897, longitude: 9.6856200322508812),
                    CLLocationCoordinate2D(latitude: 50.565091845753265, longitude: 9.6856585890054703),
                    CLLocationCoordinate2D(latitude: 50.565049678110846, longitude: 9.6857675537467003),
                    CLLocationCoordinate2D(latitude: 50.565037112997985, longitude: 9.685753807425499)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564981954242548, longitude: 9.6858356148004532),
                    CLLocationCoordinate2D(latitude: 50.565014112443713, longitude: 9.6858644485473633),
                    CLLocationCoordinate2D(latitude: 50.565049678110846, longitude: 9.6857675537467003),
                    CLLocationCoordinate2D(latitude: 50.565037112997985, longitude: 9.685753807425499)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.56506032650897, longitude: 9.6856200322508812),
                    CLLocationCoordinate2D(latitude: 50.565091845753265, longitude: 9.6856585890054703),
                    CLLocationCoordinate2D(latitude: 50.565049678110846, longitude: 9.6857675537467003),
                    CLLocationCoordinate2D(latitude: 50.565037112997985, longitude: 9.685753807425499)
                ]
            ]
        ),
        396 : (
            CLLocationCoordinate2D(latitude: 50.565055641214094, longitude: 9.6855281665921211), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565046696558944, longitude: 9.6853970736265182),
                    CLLocationCoordinate2D(latitude: 50.565087160461523, longitude: 9.6854366362094879),
                    CLLocationCoordinate2D(latitude: 50.565096956980085, longitude: 9.6854138374328613),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854010969400406),
                    CLLocationCoordinate2D(latitude: 50.565062882124145, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.565066928514582, longitude: 9.6854560822248459),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854661405086517),
                    CLLocationCoordinate2D(latitude: 50.565107818335221, longitude: 9.6854909509420395),
                    CLLocationCoordinate2D(latitude: 50.565067780386208, longitude: 9.6855979040265083),
                    CLLocationCoordinate2D(latitude: 50.565054789342241, longitude: 9.6855861693620682)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564981954242548, longitude: 9.6858356148004532),
                    CLLocationCoordinate2D(latitude: 50.565014112443713, longitude: 9.6858644485473633),
                    CLLocationCoordinate2D(latitude: 50.565091845753265, longitude: 9.6856585890054703),
                    CLLocationCoordinate2D(latitude: 50.56506032650897, longitude: 9.6856200322508812),
                    CLLocationCoordinate2D(latitude: 50.565067780386208, longitude: 9.6855979040265083),
                    CLLocationCoordinate2D(latitude: 50.565054789342241, longitude: 9.6855861693620682)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565187255229141, longitude: 9.6852958202362061),
                    CLLocationCoordinate2D(latitude: 50.565067780386208, longitude: 9.6855979040265083),
                    CLLocationCoordinate2D(latitude: 50.565054789342241, longitude: 9.6855861693620682)
                ]
            ]
        ),
        591 : (
            CLLocationCoordinate2D(latitude: 50.565154671211111, longitude: 9.6851573511958122), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565046696558944, longitude: 9.6853970736265182),
                    CLLocationCoordinate2D(latitude: 50.565087160461523, longitude: 9.6854366362094879),
                    CLLocationCoordinate2D(latitude: 50.565096956980085, longitude: 9.6854138374328613),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854010969400406),
                    CLLocationCoordinate2D(latitude: 50.565062882124145, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.565066928514582, longitude: 9.6854560822248459),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854661405086517),
                    CLLocationCoordinate2D(latitude: 50.565102920077329, longitude: 9.6854912862181664),
                    CLLocationCoordinate2D(latitude: 50.565214302076654, longitude: 9.6851828321814537),
                    CLLocationCoordinate2D(latitude: 50.565204718549793, longitude: 9.6851737797260284)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564957888819379, longitude: 9.685896635055542),
                    CLLocationCoordinate2D(latitude: 50.564951286798475, longitude: 9.6858889237046242),
                    CLLocationCoordinate2D(latitude: 50.564938295722399, longitude: 9.6859261393547058),
                    CLLocationCoordinate2D(latitude: 50.564939147596334, longitude: 9.6859492734074593),
                    CLLocationCoordinate2D(latitude: 50.564951073830059, longitude: 9.6859398856759071),
                    CLLocationCoordinate2D(latitude: 50.564965768649557, longitude: 9.68589898198843),
                    CLLocationCoordinate2D(latitude: 50.56496640755465, longitude: 9.6858721598982811),
                    CLLocationCoordinate2D(latitude: 50.565214302076654, longitude: 9.6851828321814537),
                    CLLocationCoordinate2D(latitude: 50.565204718549793, longitude: 9.6851737797260284)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565225589339157, longitude: 9.6853327006101608),
                    CLLocationCoordinate2D(latitude: 50.565216005814563, longitude: 9.6853440999984741),
                    CLLocationCoordinate2D(latitude: 50.565235385828942, longitude: 9.6853595227003098),
                    CLLocationCoordinate2D(latitude: 50.565247950888924, longitude: 9.68535415828228),
                    CLLocationCoordinate2D(latitude: 50.565254339901195, longitude: 9.6853414177894592),
                    CLLocationCoordinate2D(latitude: 50.565250293526859, longitude: 9.6853209659457207),
                    CLLocationCoordinate2D(latitude: 50.565233256157413, longitude: 9.6853028610348701),
                    CLLocationCoordinate2D(latitude: 50.565184699620687, longitude: 9.6852864325046539),
                    CLLocationCoordinate2D(latitude: 50.565214302076654, longitude: 9.6851828321814537),
                    CLLocationCoordinate2D(latitude: 50.565204718549793, longitude: 9.6851737797260284)
                ]
            ]
        ),
        593 : (
            CLLocationCoordinate2D(latitude: 50.565230487584301, longitude: 9.6851164475083351), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565046696558944, longitude: 9.6853970736265182),
                    CLLocationCoordinate2D(latitude: 50.565087160461523, longitude: 9.6854366362094879),
                    CLLocationCoordinate2D(latitude: 50.565096956980085, longitude: 9.6854138374328613),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854010969400406),
                    CLLocationCoordinate2D(latitude: 50.565062882124145, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.565066928514582, longitude: 9.6854560822248459),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854661405086517),
                    CLLocationCoordinate2D(latitude: 50.565102920077329, longitude: 9.6854912862181664),
                    CLLocationCoordinate2D(latitude: 50.565221542962327, longitude: 9.6851643919944763)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564957888819379, longitude: 9.685896635055542),
                    CLLocationCoordinate2D(latitude: 50.564951286798475, longitude: 9.6858889237046242),
                    CLLocationCoordinate2D(latitude: 50.564938295722399, longitude: 9.6859261393547058),
                    CLLocationCoordinate2D(latitude: 50.564939147596334, longitude: 9.6859492734074593),
                    CLLocationCoordinate2D(latitude: 50.564951073830059, longitude: 9.6859398856759071),
                    CLLocationCoordinate2D(latitude: 50.564965768649557, longitude: 9.68589898198843),
                    CLLocationCoordinate2D(latitude: 50.56496640755465, longitude: 9.6858721598982811),
                    CLLocationCoordinate2D(latitude: 50.565221542962327, longitude: 9.6851643919944763)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565225589339157, longitude: 9.6853327006101608),
                    CLLocationCoordinate2D(latitude: 50.565216005814563, longitude: 9.6853440999984741),
                    CLLocationCoordinate2D(latitude: 50.565235385828942, longitude: 9.6853595227003098),
                    CLLocationCoordinate2D(latitude: 50.565247950888924, longitude: 9.68535415828228),
                    CLLocationCoordinate2D(latitude: 50.565254339901195, longitude: 9.6853414177894592),
                    CLLocationCoordinate2D(latitude: 50.565250293526859, longitude: 9.6853209659457207),
                    CLLocationCoordinate2D(latitude: 50.565233256157413, longitude: 9.6853028610348701),
                    CLLocationCoordinate2D(latitude: 50.565184699620687, longitude: 9.6852864325046539),
                    CLLocationCoordinate2D(latitude: 50.565221542962327, longitude: 9.6851643919944763)
                ]
            ]
        ),
        595 : (
            CLLocationCoordinate2D(latitude: 50.565317378109164, longitude: 9.6852515637874603), [
                CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) : [
                    CLLocationCoordinate2D(latitude: 50.565046696558944, longitude: 9.6853970736265182),
                    CLLocationCoordinate2D(latitude: 50.565087160461523, longitude: 9.6854366362094879),
                    CLLocationCoordinate2D(latitude: 50.565096956980085, longitude: 9.6854138374328613),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854010969400406),
                    CLLocationCoordinate2D(latitude: 50.565062882124145, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.565066928514582, longitude: 9.6854560822248459),
                    CLLocationCoordinate2D(latitude: 50.565083114072813, longitude: 9.6854661405086517),
                    CLLocationCoordinate2D(latitude: 50.565107605367515, longitude: 9.6854939684271812),
                    CLLocationCoordinate2D(latitude: 50.565225802306351, longitude: 9.6851808205246925),
                    CLLocationCoordinate2D(latitude: 50.565267117923135, longitude: 9.6852193772792816)
                ],
                CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) : [
                    CLLocationCoordinate2D(latitude: 50.564957888819379, longitude: 9.685896635055542),
                    CLLocationCoordinate2D(latitude: 50.564951286798475, longitude: 9.6858889237046242),
                    CLLocationCoordinate2D(latitude: 50.564938295722399, longitude: 9.6859261393547058),
                    CLLocationCoordinate2D(latitude: 50.564939147596334, longitude: 9.6859492734074593),
                    CLLocationCoordinate2D(latitude: 50.564951073830059, longitude: 9.6859398856759071),
                    CLLocationCoordinate2D(latitude: 50.564965768649557, longitude: 9.68589898198843),
                    CLLocationCoordinate2D(latitude: 50.56496640755465, longitude: 9.6858721598982811),
                    CLLocationCoordinate2D(latitude: 50.565225802306351, longitude: 9.6851808205246925),
                    CLLocationCoordinate2D(latitude: 50.565267117923135, longitude: 9.6852193772792816)
                ],
                CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) : [
                    CLLocationCoordinate2D(latitude: 50.565225589339157, longitude: 9.6853327006101608),
                    CLLocationCoordinate2D(latitude: 50.565216005814563, longitude: 9.6853440999984741),
                    CLLocationCoordinate2D(latitude: 50.565235385828942, longitude: 9.6853595227003098),
                    CLLocationCoordinate2D(latitude: 50.565247950888924, longitude: 9.68535415828228),
                    CLLocationCoordinate2D(latitude: 50.565254339901195, longitude: 9.6853414177894592),
                    CLLocationCoordinate2D(latitude: 50.565250293526859, longitude: 9.6853209659457207),
                    CLLocationCoordinate2D(latitude: 50.565233256157413, longitude: 9.6853028610348701),
                    CLLocationCoordinate2D(latitude: 50.565184699620687, longitude: 9.6852864325046539),
                    CLLocationCoordinate2D(latitude: 50.565225802306351, longitude: 9.6851808205246925),
                    CLLocationCoordinate2D(latitude: 50.565267117923135, longitude: 9.6852193772792816)
                ]
            ]
        )
    ]
    
    let universityCampusArea = CLLocationCoordinate2D(latitude: 50.5650077, longitude: 9.6853589)
    let centerCoordinateGeb46E = CLLocationCoordinate2D(latitude: 50.5650899, longitude: 9.6855439)
    
    let stepsInsideUniversity = [
        CLLocationCoordinate2D(latitude: 50.563954500000001, longitude: 9.6852432000000004) : [
            CLLocationCoordinate2D(latitude: 50.564386278163909, longitude: 9.6856210380792618)
        ],
        CLLocationCoordinate2D(latitude: 50.564197700000001, longitude: 9.6845296999999988) : [
            CLLocationCoordinate2D(latitude: 50.564402676926854, longitude: 9.684707410633564),
            CLLocationCoordinate2D(latitude: 50.564451873181468, longitude: 9.6849659085273743),
            CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977) // gebaude 46(E) main entrance 1
        ],
        CLLocationCoordinate2D(latitude: 50.565794099999998, longitude: 9.6842638000000001) : [
            CLLocationCoordinate2D(latitude: 50.565364443743256, longitude: 9.6854192018508911),
            CLLocationCoordinate2D(latitude: 50.565264988253055, longitude: 9.6853310242295265) // gebaude 46(E) entrance 3
        ],
        CLLocationCoordinate2D(latitude: 50.564532999999997, longitude: 9.6879981999999991) : [
            CLLocationCoordinate2D(latitude: 50.564700196349428, longitude: 9.6875123307108879),
            CLLocationCoordinate2D(latitude: 50.564799227093438, longitude: 9.6874818205833435),
            CLLocationCoordinate2D(latitude: 50.564791347235399, longitude: 9.6874083951115608),
            CLLocationCoordinate2D(latitude: 50.565026464594624, longitude: 9.6867502480745316),
            CLLocationCoordinate2D(latitude: 50.565014751348144, longitude: 9.6866587176918983),
            CLLocationCoordinate2D(latitude: 50.564953842419577, longitude: 9.6865266188979149),
            CLLocationCoordinate2D(latitude: 50.565069800000003, longitude: 9.6862168000000004),
            CLLocationCoordinate2D(latitude: 50.564897192785949, longitude: 9.6860646083950996),
            CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788) // gebaude 46(E) entrance 2
        ]
    ]
    
    let subStepsInsideUniversity = [
        CLLocationCoordinate2D(latitude: 50.563954500000001, longitude: 9.6852432000000004) : [
            1 : [
                    CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977),
                    CLLocationCoordinate2D(latitude: 50.564930841824669, longitude: 9.6854161843657494),
                    CLLocationCoordinate2D(latitude: 50.564386278163909, longitude: 9.6856210380792618)
            ],
            2 : [
                    CLLocationCoordinate2D(latitude: 50.5649281, longitude: 9.6859788),
                    CLLocationCoordinate2D(latitude: 50.564897192785949, longitude: 9.6860646083950996),
                    CLLocationCoordinate2D(latitude: 50.564386278163909, longitude: 9.6856210380792618)
            ]
        ]
    ]
    
    let locationManager = CLLocationManager()
    
    var geb: String? = nil
    var floor: Int? = nil
    var raum: Int? = nil
    var duration: String? = nil
    var googleDirection: GoogleDirection? = nil
    var raumMarker: GMSMarker? = nil
    var floorOverlay: GMSGroundOverlay? = nil
    var routePolylines = [GMSPolyline]()
    var universityBlock1: GMSCoordinateBounds? = nil
    var shortestPathFromGeb46E = [String : (distance: Int, parent: String?)]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let cameraPostion = GMSCameraPosition.camera(withLatitude: self.universityCampusArea.latitude, longitude: universityCampusArea.longitude, zoom: 20) // 18
        
        let mapView = GMSMapView.map(withFrame: .zero, camera: cameraPostion)
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        
        self.floorOverlay = GMSGroundOverlay(position: self.centerCoordinateGeb46E, icon: UIImage(named: "E\(self.floor!).png"), zoomLevel: CGFloat(19.7))
        self.floorOverlay!.bearing = 30
        self.floorOverlay!.map = mapView
        
        let raumIntValue = self.geb!.sumOfAsciiValues() + self.floor! + self.raum!
        self.raumMarker = GMSMarker(position: self.raumCoordinates[raumIntValue]!.0)
        self.raumMarker!.title = "Free for next \(self.duration!)"
        self.raumMarker!.map = mapView
    
        let block1Path = GMSMutablePath()
        block1Path.add(CLLocationCoordinate2D(latitude: 50.564934249320913, longitude: 9.6867069974541664))
        block1Path.add(CLLocationCoordinate2D(latitude: 50.563838939555083, longitude: 9.6857182681560516))
        block1Path.add(CLLocationCoordinate2D(latitude: 50.564620545664518, longitude: 9.6831188723444939))
        block1Path.add(CLLocationCoordinate2D(latitude: 50.565801662070058, longitude: 9.6841840445995331))
        
        self.universityBlock1 = GMSCoordinateBounds(path: block1Path)
        
//        let block1Polygon = GMSPolygon(path: block1Path)
//        block1Polygon.strokeWidth = 7
//        block1Polygon.strokeColor = UIColor.blue
//        block1Polygon.map = mapView
//        self.universityBlock1Vertexs.keys.forEach { vertex in
//            self.drawShortestPathOnMap(destination: vertex, mapView: mapView)
//        }
        
        self.view = mapView
        
        let floorSwitcher = UISegmentedControl(items: self.floorStringValues)
        floorSwitcher.selectedSegmentIndex = self.floorIntValues.index(where: { $0 == self.floor! })!
        floorSwitcher.autoresizingMask = .flexibleWidth
        floorSwitcher.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        floorSwitcher.addTarget(self, action: #selector(GoogleMapViewController.drawFloorPlanOnMap(_:)), for: .valueChanged)
        self.navigationItem.titleView = floorSwitcher
        
        self.navigation.delegate = self
        
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.activityType = CLActivityType.otherNavigation
        self.locationManager.distanceFilter = 100
//        self.locationManager.startUpdatingLocation()
    }
    
    func drawShortestPathOnMap(destination: String, mapView: GMSMapView) {
        
        var vertex = destination
        
        let shortestPath = GMSMutablePath()
        shortestPath.add(self.universityBlock1Vertexs[vertex]!)
        
        var counter = 1
        
        while(self.shortestPathFromGeb46E[vertex]!.parent != nil) {
            
            vertex = self.shortestPathFromGeb46E[vertex]!.parent!
            shortestPath.add(self.universityBlock1Vertexs[vertex]!)
            
            counter += 1
        }
        
        guard counter != 1 else {
            return
        }
        
        let polylineFromShortestPath = GMSPolyline(path: shortestPath)
        polylineFromShortestPath.strokeWidth = 5
        polylineFromShortestPath.strokeColor = UIColor.green
        polylineFromShortestPath.zIndex = 1
        polylineFromShortestPath.map = mapView
        
        self.routePolylines.append(polylineFromShortestPath)
    }
    
    @IBAction func drawFloorPlanOnMap(_ sender: UISegmentedControl) {
        
        let mapView = self.view as! GMSMapView
        let currentFloor = self.floorIntValues[sender.selectedSegmentIndex]
        
        self.floorOverlay!.icon = UIImage(named: "E\(currentFloor).png")
        self.floorOverlay!.zIndex = currentFloor == self.floor! ? 0 : 2
        
        self.raumMarker?.map = currentFloor == self.floor! ? mapView : nil
        
        mapView.animate(toLocation: self.centerCoordinateGeb46E)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation = locations.last!
        
        (self.view as! GMSMapView).animate(toLocation: currentLocation.coordinate)
        
        self.routePolylines.forEach { routePolyline in routePolyline.map = nil }
        self.routePolylines.removeAll()
        
        let origin = currentLocation.coordinate
//        self.navigation.getDirectionFromDistanceMatrix(origins: [origin], destinations: self.stepsInsideUniversity.keys.sorted(by: { destCoord1, destCoord2 in destCoord1.hashValue < destCoord2.hashValue }))
    }

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        print("\nTap At: \(coordinate)")
        print("Within university block 1: \(self.universityBlock1!.contains(coordinate))\n")
        
        let tapMarker = GMSMarker(position: coordinate)
        tapMarker.title = "\(coordinate.latitude), \(coordinate.longitude)"
        tapMarker.map = mapView
        
        self.routePolylines.forEach { routePolyline in routePolyline.map = nil }
        self.routePolylines.removeAll()
        
        let insideUniversityArea = self.universityBlock1!.contains(coordinate)
        let destinations = insideUniversityArea ? self.universityBlock1Vertexs.values.sorted(by: { $0.hashValue < $1.hashValue })
            : self.stepsInsideUniversity.keys.sorted(by: { destCoord1, destCoord2 in destCoord1.hashValue < destCoord2.hashValue })
        
        self.navigation.getDirectionFromDistanceMatrix(origins: [coordinate], destinations: destinations, insideUniversityArea: insideUniversityArea)
    }
    
    func showDirectionInsideUniversity(_ nearestCoordinate: CLLocationCoordinate2D) {
        
        // draw line from current location to start step
        DispatchQueue.main.async {
            
            let mapView = self.view as! GMSMapView
            let nearestVertex = self.universityBlock1Vertexs.filter({ $0.value == nearestCoordinate }).first!.key
            
            self.drawShortestPathOnMap(destination: nearestVertex, mapView: mapView)
            
            let gebEntrance = CLLocationCoordinate2D(latitude: 50.56500942714424, longitude: 9.6854879334568977)
            let raumIntValue = self.geb!.sumOfAsciiValues() + self.floor! + self.raum!
            let raumPath = GMSMutablePath()
            raumPath.add(gebEntrance)
            self.raumCoordinates[raumIntValue]!.1[gebEntrance]!.forEach { step in raumPath.add(step) }
            
            let raumPolyline = GMSPolyline(path: raumPath)
            raumPolyline.strokeWidth = 5
            raumPolyline.strokeColor = UIColor.green
            raumPolyline.zIndex = 1
            raumPolyline.map = mapView
            
            self.routePolylines.append(raumPolyline)
        }
    }
    
    func showDirectionOutsideUniversity(_ steps: [GoogleStep]) {
        
        // draw line from current location to start step
        DispatchQueue.main.async {
            
            let mapView = self.view as! GMSMapView
            let path = GMSMutablePath()
            
            steps.forEach { step in
                
                path.add(CLLocationCoordinate2D(latitude: step.start_location.lat, longitude: step.start_location.lng))
                path.add(CLLocationCoordinate2D(latitude: step.end_location.lat, longitude: step.end_location.lng))
            }
            
            let lastStep = steps.last!
            let destination = CLLocationCoordinate2D(latitude: lastStep.end_location.lat, longitude: lastStep.end_location.lng)
            
            // steps inside university
            self.stepsInsideUniversity[destination]!.forEach { step in path.add(step) }
            
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 5
            polyline.strokeColor = UIColor.green
            polyline.zIndex = 1
            polyline.map = mapView
            
            self.routePolylines.append(polyline)
            
            let raumIntValue = self.geb!.sumOfAsciiValues() + self.floor! + self.raum!
            
            // sub steps inside university
            if let subSteps = self.subStepsInsideUniversity[destination] {
                
                for subStep in subSteps {
                    
                    let subPath = GMSMutablePath()
                    subStep.value.forEach { step in subPath.add(step) }
                    
                    let subPolyline = GMSPolyline(path: subPath)
                    subPolyline.strokeWidth = 5
                    subPolyline.strokeColor = subStep.key == 1 ? UIColor.green : UIColor.purple
                    subPolyline.zIndex = 1
                    subPolyline.map = mapView
                    
                    self.routePolylines.append(subPolyline)
                    
                    let buildingEntrance = subStep.value.first!
                    let roomPath = GMSMutablePath()
                    roomPath.add(buildingEntrance)
                    self.raumCoordinates[raumIntValue]!.1[buildingEntrance]!.forEach { step in roomPath.add(step) }
                    
                    let roomPolyline = GMSPolyline(path: roomPath)
                    roomPolyline.strokeWidth = 5
                    roomPolyline.strokeColor = subStep.key == 1 ? UIColor.green : UIColor.purple
                    roomPolyline.zIndex = 1
                    roomPolyline.map = mapView
                    
                    self.routePolylines.append(roomPolyline)
                }
                
                return
            }
            
            let gebEntrance = self.stepsInsideUniversity[destination]!.last!
            let raumPath = GMSMutablePath()
            raumPath.add(gebEntrance)
            self.raumCoordinates[raumIntValue]!.1[gebEntrance]!.forEach { step in raumPath.add(step) }
            
            let raumPolyline = GMSPolyline(path: raumPath)
            raumPolyline.strokeWidth = 5
            raumPolyline.strokeColor = UIColor.green
            raumPolyline.zIndex = 1
            raumPolyline.map = mapView
            
            self.routePolylines.append(raumPolyline)
        }
    }
    
    func processDidComplete(then dto: Any) {
        
        switch dto {
            
            case let steps as [GoogleStep]:
                self.showDirectionOutsideUniversity(steps)
                break
            
            case let nearestCoordinate as CLLocationCoordinate2D:
                self.showDirectionInsideUniversity(nearestCoordinate)
                break
            
            default: print("No match.")
        }
    }
    
    func processDidAbort(reason message: String) {
        
        DispatchQueue.main.async {
            
            let abortAlert = UIAlertController(title: "Process is aborted.", message: "Reason: " + message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            abortAlert.addAction(cancelAction)
            self.present(abortAlert, animated: true)
        }
    }
    
}
