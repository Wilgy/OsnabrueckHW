% the_worm.pl - File for HW09, T02
% implements a 'feasible' heuristic for traversing through the internet
%
% Author: T. Wilgenbusch, K. Hipkin, T. Fairman, B. Dell

% --------------------------------------------------------------
% The Worm
% --------------------------------------------------------------
% (Thanks again to Manuel)
% So there you are. Your academic career as a cognitive scientist took a wrong
% turn somewhere, and now you wrote a virus with the ultimate goal of 
% infecting the desktop computer of your arch rival, Jill Yates.
% 
% However, security is rather tight these days, and most machines use 
% firewalls, traces and other measures to keep out people like you. 
% Fortunately you were able to acquire a reduced topology of the internet,
% given below.
%
% The virus can actively replicate itself and spread from one machine to 
% another (so technically speaking, it is a worm), however the less security
% a system has, the quicker the virus can work. Furthermore, the virus can
% only infect a system whose security level is at most one level higher
% than that of the current host. Hence if the virus is currently on the
% machine "asahi" it can hop to "asimov" but not to "beet", however from
% "beet" it can hop to "asahi" (but not to "asimov", as they are not 
% connected). 
%
% The cost of one infection is the security level of 
% the system to be infected, i.e. to hop from "asahi"
% to "asimov" has a cost of 4.
% 
% Your task is to implement a feasible heuristic for the route through the
% internet from your own machine, "asimov", to your rivals box, "jillyates".
% Use the implementation of a general search engine and
% extend it to handle the strategies 'hill-climbing', 'greedy' and 'A*'
% to find the shortes route from "asimov" to "jillyates". Make sure the route
% is valid, i.e. you don't jump to systems whose security is more than one
% level above the security of the current system.

% node(Name, SecurityLevel, ConnectedNodes)
node(albertjansen,2,[beet, subirachs, harutoriko, gasprinskij, mcBride, voss]).
node(anthennig,2,[beet, efremiana, harutoriko, salzburg]).
node(asahi,3,[asimov, beet, subirachs, harutoriko, strekov, gasprinskij, mcBride]).
node(asimov,4,[macRobert, gounelle, wentworth, panizon, schrodinger, yucatan, aurora, fallersleben, shapleya, epetersen, polyakhova, vittorio]).
node(aspasia,2,[poe, neilpeart]).
node(aurelia,2,[beet, harutoriko]).
node(aurora,7,[macRobert, hortulana, gounelle, hanff, conniewalker, okabayashi, wentworth, shunkai, haffner, jamesearly, subirachs, panizon, sutton, caussols, feijth, ninnemann, vitja, chabot, strekov, satpaev, schrodinger, swann, luda, yucatan, tRIUMF, leung, manjiro, mauersberger, fallersleben, shapleya, asimov, epetersen, celsius, polyakhova, yoneta, onnie, vittorio]).
node(beet,7,[asahi, meslier, tolstikov, coelum, fujiiekio, mcHone, yumiko, palamedes, yurkanin, mutsumi, subirachs, efremiana, caussols, iphidamas, devine, gershberg, harutoriko, chabot, putzi, excubitor, strekov, satpaev, shane, aurelia, tRIUMF, luisapla, anthennig, norikura, ursula, gasprinskij, kudara, sorin, salzburg, mcBride, nicole, cagney, leCreusot, albertjansen, yoneta, pugovkin, carver, voss]).
node(belisana,1,[salzburg]).
node(beryl,6,[jasonelloyd, kathydouglas, repsolda, wendeline, lorifini, mutsumi, caussols, maoyisheng, iphidamas, keats, michanikos, satpaev, shane, tRIUMF, jaroff, sorin, ohmura, zibiturtle, nathaniel]).
node(billschaefer,1,[lorifini, wertheimer, zibiturtle]).
node(bolsche,2,[valborg]).
node(bonini,4,[macRobert, gounelle, yamasakimakoto, fallersleben, polyakhova, vittorio]).
node(bouguer,2,[lorifini, wertheimer, zibiturtle]).
node(boyarchuk,3,[gunn, panizon, nakamura, samaschneid, valborg, epetersen, polyakhova]).
node(cagney,3,[beet, yurkanin, mutsumi, subirachs, caussols, satpaev, tRIUMF, gasprinskij, sorin, salzburg, mcBride]).
node(carver,4,[beet, fujiiekio, yurkanin, efremiana, iphidamas, gershberg, harutoriko, putzi, shane, norikura, gasprinskij, salzburg, mcBride, nicole, leCreusot]).
node(caseynicole,1,[macRobert, gounelle, fallersleben, vittorio]).
node(caussols,6,[hortulana, duras, tolstikov, beet, beryl, kenwill, yurkanin, picha, mutsumi, haffner, jamesearly, subirachs, panizon, rozenblyum, mariafelix, sutton, neilpeart, maoyisheng, starrfield, mussorgskia, michanikos, chabot, strekov, prast, satpaev, sarahmarzen, tRIUMF, rambhia, aurora, gasprinskij, dido, sorin, mcBride, cagney, ohmura, haruna, yebes, nathaniel]).
node(celsius,2,[wentworth, panizon, vitja, luda, aurora, epetersen, polyakhova]).
node(chabot,6,[hortulana, duras, tolstikov, beet, kenwill, yurkanin, picha, mutsumi, haffner, jamesearly, subirachs, panizon, rozenblyum, mariafelix, sutton, caussols, neilpeart, feijth, mussorgskia, strekov, prast, satpaev, sarahmarzen, tRIUMF, luisapla, rambhia, leung, aurora, gasprinskij, sorin, mcBride, epetersen, ohmura, haruna, polyakhova, yoneta, yebes]).
node(ciaurro,4,[poe, rubik, neilpeart, kurobe]).
node(clasien,1,[valborg]).
node(coelum,3,[beet, yurkanin, subirachs, efremiana, harutoriko, strekov, gasprinskij, salzburg, mcBride, voss]).
node(conniewalker,3,[wentworth, subirachs, panizon, vitja, luda, aurora, shapleya, epetersen, polyakhova]).
node(daisetsuzan,1,[neilpeart]).
node(devine,1,[beet, salzburg]).
node(dido,1,[mutsumi, caussols, satpaev, tRIUMF, sorin]).
node(donaldpray,4,[pribram, lorifini, shchedrin, wertheimer, neilpeart, ohmura, zibiturtle, georgekaplan]).
node(duras,1,[caussols, neilpeart, chabot, satpaev, tRIUMF]).
node(efremiana,5,[meslier, coelum, beet, fujiiekio, mcHone, yumiko, yurkanin, subirachs, iphidamas, gershberg, harutoriko, putzi, shane, anthennig, norikura, gasprinskij, salzburg, mcBride, nicole, leCreusot, carver, voss]).
node(ehrenfreund,3,[poe, ockeghem, rubik, neilpeart, kurobe]).
node(epetersen,8,[gunn, macRobert, hortulana, jurijvega, gounelle, hanff, conniewalker, okabayashi, wentworth, palamedes, fredearly, haffner, jamesearly, subirachs, pien, panizon, nakamura, feijth, ninnemann, vitja, chabot, samaschneid, strekov, satpaev, schrodinger, luda, yucatan, tRIUMF, leung, manjiro, mauersberger, gersuind, aurora, gasprinskij, fallersleben, valborg, shapleya, boyarchuk, sherman, asimov, celsius, polyakhova, yoneta, onnie, vittorio]).
node(excubitor,3,[beet, subirachs, harutoriko, gasprinskij, valborg, mcBride, voss]).
node(fallersleben,7,[macRobert, hortulana, caseynicole, poe, gounelle, ioannisiani, bonini, ockeghem, okabayashi, wentworth, shunkai, haffner, panizon, rubik, mcSween, schrodinger, swann, mila, yucatan, mauersberger, aurora, yamasakimakoto, shapleya, asimov, epetersen, polyakhova, onnie, vittorio]).
node(feijth,3,[hortulana, jamesearly, subirachs, panizon, chabot, strekov, satpaev, tRIUMF, aurora, gasprinskij, epetersen, polyakhova, yoneta]).
node(fredearly,3,[gunn, nakamura, samaschneid, valborg, epetersen]).
node(fujiiekio,5,[beet, peaker, efremiana, iphidamas, gershberg, putzi, shane, norikura, salzburg, nicole, leCreusot, carver]).
node(gasprinskij,6,[hortulana, tolstikov, coelum, beet, gaussia, palamedes, yurkanin, mutsumi, jamesearly, subirachs, panizon, efremiana, caussols, feijth, harutoriko, chabot, excubitor, strekov, prast, satpaev, tRIUMF, luisapla, ursula, valborg, kudara, sorin, salzburg, mcBride, sherman, cagney, epetersen, asahi, albertjansen, yoneta, pugovkin, carver, voss]).
node(gaussia,1,[subirachs, tRIUMF, gasprinskij]).
node(georgekaplan,3,[donaldpray, neilpeart, mussorgskia, satpaev]).
node(gershberg,5,[beet, fujiiekio, efremiana, iphidamas, putzi, shane, norikura, salzburg, nicole, leCreusot, carver]).
node(gersuind,1,[valborg, epetersen]).
node(gounelle,6,[macRobert, hortulana, caseynicole, ioannisiani, bonini, ockeghem, okabayashi, wentworth, shunkai, haffner, panizon, mcSween, vitja, schrodinger, swann, luda, mila, yucatan, leung, mauersberger, aurora, yamasakimakoto, fallersleben, shapleya, asimov, epetersen, polyakhova, onnie, vittorio]).
node(gunn,4,[fredearly, nakamura, samaschneid, valborg, shapleya, boyarchuk, epetersen, polyakhova]).
node(haffner,4,[hortulana, gounelle, okabayashi, wentworth, jamesearly, subirachs, panizon, sutton, caussols, vitja, chabot, satpaev, schrodinger, tRIUMF, leung, aurora, fallersleben, epetersen, polyakhova, onnie, vittorio]).
node(hanff,2,[panizon, luda, aurora, epetersen, polyakhova]).
node(haruna,2,[tolstikov, mutsumi, subirachs, caussols, chabot, satpaev, tRIUMF, sorin]).
node(harutoriko,5,[coelum, beet, palamedes, yurkanin, subirachs, efremiana, excubitor, strekov, aurelia, tRIUMF, anthennig, gasprinskij, valborg, salzburg, mcBride, asahi, albertjansen, yoneta, carver, voss]).
node(hortulana,5,[tolstikov, gounelle, okabayashi, wentworth, mutsumi, haffner, jamesearly, subirachs, panizon, sutton, caussols, neilpeart, feijth, vitja, chabot, strekov, prast, satpaev, schrodinger, luda, tRIUMF, leung, aurora, gasprinskij, fallersleben, sorin, epetersen, polyakhova, yoneta, onnie, vittorio]).
node(ioannisiani,1,[macRobert, gounelle, fallersleben, vittorio]).
node(iphidamas,4,[jasonelloyd, beet, fujiiekio, beryl, efremiana, gershberg, michanikos, shane, salzburg, nicole, carver]).
node(ishkov,3,[valborg]).
node(jamesearly,4,[hortulana, tolstikov, wentworth, haffner, subirachs, panizon, caussols, feijth, vitja, chabot, strekov, satpaev, luda, tRIUMF, leung, aurora, gasprinskij, epetersen, polyakhova, yoneta]).
node(jaroff,3,[beryl, lorifini, michanikos, ohmura, zibiturtle]).
node(jasonelloyd,3,[beryl, iphidamas, michanikos, shane, salzburg]).
node(jillYates,9,[poe, neilpeart]).
node(jurijvega,3,[palamedes, subirachs, panizon, luda, valborg, epetersen, polyakhova, yoneta]).
node(kathydouglas,2,[beryl, mutsumi, maoyisheng, michanikos, satpaev, tRIUMF, sorin]).
node(keats,3,[beryl, lorifini, wertheimer, neilpeart, michanikos, ohmura, zibiturtle, nathaniel]).
node(kenwill,1,[caussols, neilpeart, chabot, satpaev, tRIUMF]).
node(korczak,1,[mutsumi, satpaev, tRIUMF, sorin]).
node(kudara,1,[beet, gasprinskij, mcBride]).
node(kurobe,4,[poe, ockeghem, rubik, neilpeart, mila, ciaurro, ehrenfreund]).
node(leCreusot,3,[beet, fujiiekio, efremiana, gershberg, salzburg, carver]).
node(leung,3,[hortulana, gounelle, wentworth, haffner, jamesearly, subirachs, panizon, vitja, chabot, satpaev, tRIUMF, aurora, epetersen, polyakhova]).
node(lorifini,6,[bouguer, donaldpray, beryl, wendeline, pribram, mutsumi, wertheimer, neilpeart, keats, michanikos, satpaev, billschaefer, jaroff, ohmura, zibiturtle, nathaniel]).
node(luda,4,[hortulana, jurijvega, gounelle, hanff, conniewalker, wentworth, jamesearly, subirachs, panizon, vitja, aurora, valborg, shapleya, epetersen, celsius, polyakhova, yoneta]).
node(luisapla,2,[beet, yurkanin, subirachs, chabot, strekov, satpaev, tRIUMF, gasprinskij, mcBride]).
node(macRobert,5,[caseynicole, gounelle, ioannisiani, bonini, ockeghem, okabayashi, wentworth, shunkai, panizon, schrodinger, aurora, yamasakimakoto, fallersleben, shapleya, asimov, epetersen, polyakhova, onnie, vittorio]).
node(manjiro,2,[panizon, aurora, epetersen, polyakhova]).
node(maoyisheng,4,[kathydouglas, beryl, mutsumi, caussols, michanikos, satpaev, tRIUMF, sorin, ohmura, zibiturtle, nathaniel]).
node(mariafelix,2,[mutsumi, caussols, chabot, satpaev, tRIUMF, sorin]).
node(mauersberger,1,[gounelle, aurora, fallersleben, epetersen, polyakhova, vittorio]).
node(mcBride,5,[tolstikov, coelum, beet, palamedes, yurkanin, mutsumi, subirachs, efremiana, caussols, harutoriko, chabot, excubitor, strekov, satpaev, tRIUMF, luisapla, gasprinskij, kudara, sorin, salzburg, cagney, asahi, albertjansen, yoneta, pugovkin, carver, voss]).
node(mcHone,1,[beet, efremiana, salzburg]).
node(mcSween,2,[gounelle, fallersleben, vittorio]).
node(meslier,2,[beet, efremiana, salzburg]).
node(michanikos,7,[jasonelloyd, kathydouglas, beryl, repsolda, wendeline, lorifini, mutsumi, caussols, wertheimer, maoyisheng, iphidamas, keats, satpaev, shane, tRIUMF, jaroff, sorin, ohmura, zibiturtle, nathaniel]).
node(mila,3,[poe, gounelle, ockeghem, rubik, neilpeart, kurobe, fallersleben, vittorio]).
node(mussorgskia,4,[mutsumi, rozenblyum, caussols, neilpeart, chabot, satpaev, sarahmarzen, tRIUMF, sorin, ohmura, georgekaplan, nathaniel]).
node(mutsumi,6,[hortulana, kathydouglas, tolstikov, beet, beryl, repsolda, yurkanin, picha, lorifini, subirachs, mariafelix, caussols, neilpeart, maoyisheng, starrfield, mussorgskia, michanikos, chabot, satpaev, tRIUMF, rambhia, korczak, ursula, gasprinskij, dido, sorin, mcBride, cagney, ohmura, zibiturtle, haruna, nathaniel]).
node(nakamura,4,[gunn, fredearly, samaschneid, valborg, boyarchuk, epetersen]).
node(nathaniel,4,[beryl, lorifini, mutsumi, caussols, wertheimer, neilpeart, maoyisheng, keats, mussorgskia, michanikos, satpaev, tRIUMF, sorin, ohmura, zibiturtle]).
node(neilpeart,8,[hortulana, duras, jillYates, poe, ricci, aspasia, donaldpray, ockeghem, sergivanov, kenwill, daisetsuzan, zelkowitz, pribram, lorifini, mutsumi, shchedrin, rozenblyum, rubik, caussols, wertheimer, kurobe, keats, mussorgskia, chabot, satpaev, sarahmarzen, mila, tRIUMF, vertinskij, ciaurro, sorin, ohmura, zibiturtle, georgekaplan, patientia, yebes, ehrenfreund, nathaniel]).
node(nicole,3,[beet, fujiiekio, efremiana, iphidamas, gershberg, shane, norikura, salzburg, carver]).
node(ninnemann,1,[panizon, aurora, epetersen, polyakhova]).
node(norikura,3,[beet, fujiiekio, efremiana, gershberg, putzi, salzburg, nicole, carver]).
node(ockeghem,4,[macRobert, poe, gounelle, rubik, neilpeart, kurobe, mila, fallersleben, vittorio, ehrenfreund]).
node(ohmura,5,[donaldpray, beryl, repsolda, lorifini, mutsumi, caussols, wertheimer, neilpeart, maoyisheng, keats, mussorgskia, michanikos, chabot, satpaev, tRIUMF, jaroff, sorin, zibiturtle, nathaniel]).
node(okabayashi,3,[macRobert, hortulana, gounelle, wentworth, haffner, aurora, fallersleben, epetersen, polyakhova, onnie, vittorio]).
node(onnie,3,[macRobert, hortulana, gounelle, okabayashi, wentworth, haffner, panizon, schrodinger, aurora, fallersleben, epetersen, polyakhova, vittorio]).
node(palamedes,4,[jurijvega, beet, subirachs, panizon, harutoriko, strekov, gasprinskij, valborg, mcBride, sherman, epetersen, yoneta, voss]).
node(panizon,6,[macRobert, hortulana, jurijvega, gounelle, hanff, conniewalker, wentworth, palamedes, haffner, jamesearly, subirachs, caussols, feijth, ninnemann, vitja, chabot, strekov, satpaev, schrodinger, luda, yucatan, tRIUMF, leung, manjiro, aurora, gasprinskij, fallersleben, valborg, shapleya, boyarchuk, asimov, epetersen, celsius, polyakhova, yoneta, onnie, vittorio]).
node(patientia,1,[neilpeart]).
node(peaker,1,[fujiiekio, salzburg]).
node(peking,1,[poe]).
node(picha,2,[yurkanin, mutsumi, caussols, chabot, satpaev, tRIUMF, sorin]).
node(pien,1,[epetersen, polyakhova]).
node(poe,6,[jillYates, aspasia, ockeghem, sergivanov, rubik, neilpeart, kurobe, rhodope, mila, ciaurro, fallersleben, rowling, vittorio, peking, ehrenfreund]).
node(polyakhova,8,[gunn, macRobert, hortulana, jurijvega, gounelle, bonini, hanff, conniewalker, okabayashi, wentworth, shunkai, haffner, jamesearly, subirachs, pien, panizon, feijth, ninnemann, vitja, chabot, strekov, satpaev, schrodinger, swann, luda, yucatan, tRIUMF, leung, manjiro, mauersberger, aurora, yamasakimakoto, fallersleben, valborg, shapleya, boyarchuk, asimov, epetersen, celsius, yoneta, onnie, vittorio]).
node(prast,2,[hortulana, subirachs, caussols, chabot, strekov, satpaev, tRIUMF, gasprinskij]).
node(pribram,3,[donaldpray, lorifini, neilpeart, zibiturtle]).
node(pugovkin,2,[beet, yurkanin, subirachs, satpaev, tRIUMF, gasprinskij, mcBride]).
node(putzi,3,[beet, fujiiekio, efremiana, gershberg, norikura, salzburg, carver]).
node(rambhia,1,[mutsumi, caussols, chabot, satpaev, tRIUMF, sorin]).
node(repsolda,2,[beryl, mutsumi, michanikos, ohmura]).
node(rhodope,1,[poe]).
node(ricci,1,[neilpeart]).
node(rowling,1,[poe]).
node(rozenblyum,3,[caussols, neilpeart, mussorgskia, chabot, satpaev, tRIUMF, sorin]).
node(rubik,4,[poe, ockeghem, neilpeart, kurobe, satpaev, mila, ciaurro, fallersleben, ehrenfreund]).
node(salzburg,8,[jasonelloyd, meslier, coelum, beet, fujiiekio, mcHone, yumiko, yurkanin, peaker, efremiana, iphidamas, devine, gershberg, harutoriko, putzi, belisana, shane, anthennig, norikura, gasprinskij, mcBride, nicole, cagney, leCreusot, carver, voss]).
node(samaschneid,5,[gunn, fredearly, nakamura, valborg, boyarchuk, epetersen]).
node(sarahmarzen,2,[caussols, neilpeart, mussorgskia, chabot, satpaev, tRIUMF]).
node(satpaev,7,[hortulana, duras, kathydouglas, tolstikov, beet, beryl, kenwill, yurkanin, picha, lorifini, mutsumi, haffner, jamesearly, subirachs, panizon, rozenblyum, rubik, mariafelix, sutton, caussols, neilpeart, feijth, maoyisheng, starrfield, mussorgskia, michanikos, chabot, strekov, prast, sarahmarzen, tRIUMF, luisapla, rambhia, korczak, leung, aurora, gasprinskij, dido, sorin, mcBride, cagney, epetersen, ohmura, zibiturtle, georgekaplan, haruna, polyakhova, pugovkin, yebes, nathaniel]).
node(schrodinger,3,[macRobert, hortulana, gounelle, wentworth, haffner, panizon, vitja, aurora, fallersleben, asimov, epetersen, polyakhova, onnie, vittorio]).
node(sergivanov,2,[poe, neilpeart]).
node(shane,4,[jasonelloyd, beet, fujiiekio, beryl, yurkanin, efremiana, iphidamas, gershberg, michanikos, salzburg, nicole, carver]).
node(shapleya,6,[gunn, macRobert, gounelle, conniewalker, wentworth, panizon, vitja, luda, yucatan, aurora, fallersleben, asimov, epetersen, polyakhova, vittorio]).
node(shchedrin,3,[donaldpray, neilpeart]).
node(sherman,2,[palamedes, subirachs, strekov, gasprinskij, epetersen, yoneta]).
node(shunkai,2,[macRobert, gounelle, wentworth, aurora, fallersleben, polyakhova, vittorio]).
node(sorin,6,[hortulana, kathydouglas, tolstikov, beet, beryl, yurkanin, picha, mutsumi, subirachs, rozenblyum, mariafelix, caussols, neilpeart, maoyisheng, starrfield, mussorgskia, michanikos, chabot, strekov, satpaev, tRIUMF, rambhia, korczak, ursula, gasprinskij, dido, mcBride, cagney, ohmura, zibiturtle, haruna, nathaniel]).
node(starrfield,1,[mutsumi, caussols, satpaev, tRIUMF, sorin]).
node(strekov,5,[hortulana, tolstikov, coelum, beet, palamedes, yurkanin, jamesearly, subirachs, panizon, caussols, feijth, harutoriko, vitja, chabot, prast, satpaev, tRIUMF, luisapla, aurora, gasprinskij, valborg, sorin, mcBride, sherman, epetersen, asahi, polyakhova, yoneta, voss]).
node(subirachs,6,[hortulana, tolstikov, jurijvega, coelum, beet, conniewalker, gaussia, palamedes, yurkanin, mutsumi, haffner, jamesearly, panizon, efremiana, caussols, feijth, harutoriko, vitja, chabot, excubitor, strekov, prast, satpaev, luda, tRIUMF, luisapla, leung, aurora, gasprinskij, valborg, sorin, mcBride, sherman, cagney, epetersen, haruna, asahi, polyakhova, albertjansen, yoneta, pugovkin, voss]).
node(sutton,2,[hortulana, haffner, caussols, chabot, satpaev, tRIUMF, aurora]).
node(swann,2,[gounelle, aurora, fallersleben, polyakhova, vittorio]).
node(tRIUMF,7,[hortulana, duras, kathydouglas, tolstikov, beet, gaussia, beryl, kenwill, yurkanin, picha, mutsumi, haffner, jamesearly, subirachs, panizon, rozenblyum, mariafelix, sutton, caussols, neilpeart, feijth, maoyisheng, starrfield, mussorgskia, harutoriko, michanikos, chabot, strekov, prast, satpaev, sarahmarzen, luisapla, rambhia, korczak, leung, ursula, aurora, gasprinskij, dido, sorin, mcBride, cagney, epetersen, ohmura, haruna, polyakhova, yoneta, pugovkin, yebes, nathaniel]).
node(tolstikov,4,[hortulana, beet, yurkanin, mutsumi, jamesearly, subirachs, caussols, chabot, strekov, satpaev, tRIUMF, gasprinskij, sorin, mcBride, haruna]).
node(ursula,2,[beet, yurkanin, mutsumi, tRIUMF, gasprinskij, sorin]).
node(valborg,6,[gunn, bolsche, jurijvega, ishkov, palamedes, fredearly, subirachs, panizon, nakamura, harutoriko, samaschneid, excubitor, strekov, luda, gersuind, gasprinskij, wangdaheng, boyarchuk, epetersen, clasien, polyakhova, yoneta, voss]).
node(vertinskij,1,[neilpeart]).
node(vitja,4,[hortulana, gounelle, conniewalker, wentworth, haffner, jamesearly, subirachs, panizon, strekov, schrodinger, luda, leung, aurora, shapleya, epetersen, celsius, polyakhova, yoneta, vittorio]).
node(vittorio,6,[macRobert, hortulana, caseynicole, poe, gounelle, ioannisiani, bonini, ockeghem, okabayashi, wentworth, shunkai, haffner, panizon, mcSween, vitja, schrodinger, swann, mila, yucatan, mauersberger, aurora, yamasakimakoto, fallersleben, shapleya, asimov, epetersen, polyakhova, onnie]).
node(voss,4,[coelum, beet, palamedes, yurkanin, subirachs, efremiana, harutoriko, excubitor, strekov, gasprinskij, valborg, salzburg, mcBride, albertjansen]).
node(wangdaheng,1,[valborg]).
node(wendeline,3,[beryl, lorifini, wertheimer, michanikos, zibiturtle]).
node(wentworth,7,[macRobert, hortulana, gounelle, conniewalker, okabayashi, shunkai, haffner, jamesearly, panizon, vitja, schrodinger, luda, yucatan, leung, aurora, fallersleben, shapleya, asimov, epetersen, celsius, polyakhova, onnie, vittorio]).
node(wertheimer,5,[bouguer, donaldpray, wendeline, lorifini, neilpeart, keats, michanikos, billschaefer, ohmura, zibiturtle, nathaniel]).
node(yamasakimakoto,4,[macRobert, gounelle, bonini, fallersleben, polyakhova, vittorio]).
node(yebes,2,[caussols, neilpeart, chabot, satpaev, tRIUMF]).
node(yoneta,4,[hortulana, jurijvega, beet, palamedes, jamesearly, subirachs, panizon, feijth, harutoriko, vitja, chabot, strekov, luda, tRIUMF, aurora, gasprinskij, valborg, mcBride, sherman, epetersen, polyakhova]).
node(yucatan,3,[gounelle, wentworth, panizon, aurora, fallersleben, shapleya, asimov, epetersen, polyakhova, vittorio]).
node(yumiko,1,[beet, efremiana, salzburg]).
node(yurkanin,5,[tolstikov, coelum, beet, picha, mutsumi, subirachs, efremiana, caussols, harutoriko, chabot, strekov, satpaev, shane, tRIUMF, luisapla, ursula, gasprinskij, sorin, salzburg, mcBride, cagney, pugovkin, carver, voss]).
node(zelkowitz,1,[neilpeart]).
node(zibiturtle,6,[bouguer, donaldpray, beryl, wendeline, pribram, lorifini, mutsumi, wertheimer, neilpeart, maoyisheng, keats, michanikos, satpaev, billschaefer, jaroff, sorin, ohmura, nathaniel]).


%----------------------------------------------------------------
% This is a search shell for informed search.
% You need to adapt it and integrate different strategies.
% you may recycle you solution of execise 1 of 
% this assignment sheet here

% to be adapted
% expand(Node, Successors) :- ... .

% to be adapted
% goalp( .... ).

%----------------------------------------------------------------
% Basic search implementation (here for A*)
%
% you need to adapt this a little bit further for the strategies

% search_a(+Start,+Endp,+Expand,-Path)
%
% +Start is called with a start state.
% +Endp contains the name of the predicate that defines the goal states.
% +Expand contains the name of the predicate that provides all successor states for a respective state.
% -Path is instatiated with a path from the start state to a goal state and the accumulated costs.
% 
% The agenda is initialized with the first path consisting only of the start state.
% The first number in the list of the path represents the value that the respective algorithm (e.g. A* or greedy) needs to sort the agenda.
% The second number in the list of the path represents the accumulated costs.
%

search_a(Start,Endp,Expand,Path) :-
   search1_a(Endp,Expand,[[0,0,Start]],Path).


% search1_a(+EndP,_Expand,+Agenda,-PathWithCosts)
%
% +Endp contains the name of the predicate that defines the goal states.
% +Agenda contains the current Agenda.
% -Path is instatiated with a path from the start state to a goal state and the accumulated costs, in case a goal state is reached. The accumulated costs are grouped with the list containing the path by using a colon. This is short for: ':(G,[End|Path])'
/*
- This is kind of the base case for the search.
- The predicate that checks for goal states is generated by applying the univ operator.
- Then the predicate is called to check for a goal state.
*/
search1_a(EndP,_Expand,[[_F,G,End|Path]|_Agenda], G:[End|Path]) :-
   EndG =.. [EndP,End],
   EndG.


% search1_a(+EndP,+Expand,+Agenda,-Path)
%
% +Endp contains the name of the predicate that defines the goal states.
% +Agenda contains the current Agenda.
% +Expand contains the name of the predicate that provides all successor states for a respective state.
% -Path is instatiated with a path from the start state to a goal state and the accumulated costs.
/*
- This is the recursion step in the search.
- The predicate that provides all successor states for a given node is generated by using the univ operator.
- Then the predicate is called to instantiate S with a list containing all states that can be reached from X.
- Afterwards, the new paths are added to the agenda and the agenda is sorted with respect to F.
- This is done by merging the agenda with the list of new paths.
- Finally, search1_a is called with the new agenda, so that the next node can be expanded.
*/
search1_a(EndP,Expand,[[F,G,X|Path]|Agenda],RPath) :-
   Exp =.. [Expand,X,S],
   Exp,
   exp_path(S,[F,G,X|Path],Pathes),
   merge_s(Pathes,Agenda,Agenda1), !,
   search1_a(EndP,Expand,Agenda1,RPath) .

% skip current path if we are in dead end
search1_a(EndP,Expand,[_|Agenda],Path) :-
   search1_a(EndP,Expand,Agenda,Path) .


% merge_s(+Paths,+Agenda,-NewAgenda)
%
% +Paths contains the remaining new paths.
% +Agenda contains the rest of the current agenda.
% -NewAgenda is instantiated with the new agenda.
/*
- The first two predicates are the base cases for the merging process. If either the paths or the agenda is empty, put the remaining paths to the end of the new agenda.
- The first recursion rule checks whether the F-value of the first path in the list of new paths is smaller than the F-value of the first path in the agenda.
- If this is the case, the first path is removed from the new agenda (which means that it is an element that comes earlier in the new agenda than the other path.
- By using a cut here we assure that the second rule is only called if the second F-value is smaller.
- In this case the second list is removed from the new agenda next.
- As a result we get a new agenda that contains paths with low F-values in the front and paths with higher F-values in the back.
- This is the strategy of informed search algorithms that use a queue, like A* and greedy search.
- They only differ in the way the respective F-values are generated.
*/
merge_s([],Agenda,Agenda) :- ! .
merge_s(Pathes,[],Pathes) :- ! .
merge_s([[F1,G1|P1]|Pathes],[[F2,G2|P2]|Agenda],[[F1,G1|P1]|Agenda1]) :-
   (F1 < F2; (F1 =< F2, G1 >= G2)), ! ,
   % F1 =< F2, ! ,
   merge_s(Pathes,[[F2,G2|P2]|Agenda],Agenda1).
merge_s([P1|Pathes],[P2|Agenda],[P2|Agenda1]) :-
   merge_s([P1|Pathes],Agenda,Agenda1).


% exp_path(+SuccessorStates,+CurrentPath,-NewPaths)
%
% +SuccessorStates contains all states that can be reached from the current state of the first path in the agenda. The expand-predicate should have added the heuristic value of this state and the costs of the transition as the first two elements of a list that has the new state as its third element.
% +CurrentPath is the current path that we took from the agenda and of which the expansions should be put back on the agenda.
% -NewPaths will be instantiated with all the generated paths.
/*
- Firstly, if no states can be reached from the current state or we have generated all new paths, then return an empty list in the third argument (base case).
- Secondly, in the recursion step take a successor state and compute G and F. You somehow have to make the strategy, that should be used, accessible to this predicate. Dependent on strategy('A*') or strategy(greedy) you should compute F1 as H + G1 or F1 as H.
- In the first rule we use member to check for cycles and if the state has already been visited it is simply removed from the state-list by the last rule. Here we have to use a cut because the head of this rule also matches the head of the next one.
- Finally, the predicate is called recursively, again with the current paths and the remaining successor nodes.
- In the third argument of this predicate the next new path is constructed and added to the list of new paths.
*/
exp_path([],_P,[]).
exp_path([[H,C,X]|R], [F,G,Y|P], [[F1,G1,X,Y|P]|Ps]) :-
   not(member(X,[Y|P])), !,
   G1 is G + C,
   F1 is H + G1,
   exp_path(R,[F,G,Y|P],Ps).
exp_path([_X|R],P,Ps) :-
   exp_path(R,P,Ps).

%------------------------------------------------------------------