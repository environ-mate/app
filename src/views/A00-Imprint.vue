<i18n>
{
  "de": {
    "title": "Impressum & Datenschutzerklärung"
  },
   "en": {
    "title": "Imprint & Privacy Policy"
  }
}
</i18n>

<template>
  <div class="modal modal" v-bind:class="{ active: this.$parent.$data.modalOpen }">
    <div class="modal-container">
        <div class="modal-header">
          <a @click="modalClose" class="btn btn-clear float-right"
             aria-label="Close"></a>

          <a href="#" @click="changeLocale('en')">en</a> | <a href="#" @click="changeLocale('de')">de</a>

          <div class="modal-title h2 text-center">
            {{ $t('title') }}
          </div>
        </div>
      <div class="modal-body">
        <div class="columns col-gapless">

          <div v-if="this.$i18n.locale === 'de'" class="column col-12">
            <h2 >Impressum</h2>

            <p>FELD M GmbH<br />
                Sandstraße 33<br />
                80335 München</p>
            <p>Telefon +49.89.5529756.0<br />
                Fax +49.89.5529756.22<br />
              E-Mail <span class="underline"><a href="mailto:contact@feld-m.de">contact@feld-m.de</a></span></p>
            <p><strong>Rechtsform</strong><br />
                Gesellschaft mit beschränkter Haftung</p>
            <p><strong>Sitz München</strong><br />
                München<br />
                Amtsgericht München<br />
                HRB 145976</p>
            <p><strong>Geschäftsführer</strong><br />
                Lutz Wiechert, Dipl. Kfm.</p>
            <p><strong>Umsatzsteuer-Ident.Nr.</strong><br />
                DE226898258</p>

            <h2 id="datenschutzerklärung-für-httpeudt2019.403.io">Datenschutzerklärung für <a href="http://eudt2019.403.io/">http://eudt2019.403.io</a></h2>
            <h6 id="informationspflichten-bei-erhebung-personenbezogener-daten-auf-der-website-httpeudt2019.403.io-art.-13-datenschutz-grundverordnung-ds-gvo">Informationspflichten bei Erhebung personenbezogener Daten auf der Website <a href="http://eudt2019.403.io">http://eudt2019.403.io</a><br />
            (Art. 13 Datenschutz-Grundverordnung (DS-GVO))</h6>

            <h6 id="allgemeines-zur-datenverarbeitung">Allgemeines zur Datenverarbeitung</h6>
            <h6 id="name-und-anschrift-des-verantwortlichen">Name und Anschrift des Verantwortlichen</h6>
            <p>Der Verantwortliche im Sinne der Datenschutz-Grundverordnung und anderer nationaler Datenschutzgesetze der Mitgliedsstaaten sowie sonstiger datenschutzrechtlicher Bestimmungen ist die:</p>
            <blockquote>
            <p>FELD M GmbH</p>
            <p>Sandstraße 33</p>
            <p>80335 München</p>
            <p>Telefon +49.89.5529756.0</p>
            <p>Fax +49.89.5529756.22</p>
            <p>Geschäftsführer: Lutz Wiechert, Dipl. Kfm.</p>
            <p><a href="mailto:contact@feld-m.de">contact@feld-m.de</a></p>
            <p><a href="https://www.feld-m.de/">https://www.feld-m.de/</a></p>
            </blockquote>
            <h6 id="kontakt-zur-datenschutzbeauftragten">Kontakt zur Datenschutzbeauftragten</h6>
            <p>Die für die Einhaltung der Datenschutzgrundverordnung sowie ergänzender datenschutzrechtlicher Bestimmungen zuständige Datenschutzbeauftragte ist die:</p>
            <blockquote>
            <p>Feld M GmbH</p>
            <p>– Datenschutz –</p>
            <p>Sandstraße 33</p>
            <p>80335 München</p>
            <p>Tel +49 (0) 89 / 60807600</p>
            <p>datenschutz@feld-m.de</p>
            </blockquote>
            <h6 id="empfänger-der-erhobenen-daten">Empfänger der erhobenen Daten</h6>
            <p>Auf <a href="http://eudt2019.403.io/">http://eudt2019.403.io</a> werden keine Daten zu Auswertungszwecken erhoben und zur Verarbeitung an Personengruppen adressiert. Es gibt insofern keine Empfänger von personenbezogenen Daten.</p>
            <h6 id="umfang-der-verarbeitung-personenbezogener-daten">Umfang der Verarbeitung personenbezogener Daten</h6>
            <p>Wenn wir personenbezogene Daten verarbeiten, tun wir dies im Einklang mit den Bestimmungen der EU Datenschutz-Grundverordnung (DS-GVO) und dem Bundesdatenschutzgesetz (BDSG-neu) auf Basis folgender Rechtsgrundlagen:</p>
            <blockquote>
            <p>(1) Art. 6 Abs. 1 lit. b DS-GVO<br />
            Die Verarbeitung personenbezogener Daten kann auf Grundlage der Erfüllung eines Vertrags bzw. vorvertraglicher Maßnahmen geschehen.</p>
            <p>(2) Art. 6 Abs. 1 lit. f DS-GVO<br />
            Soweit erforderlich verarbeitet die verantwortliche Stelle personenbezogene Daten zur Wahrung der eigenen berechtigten Interessen.</p>
            </blockquote>
            <p>Entsprechend den gesetzlichen Vorgaben erheben wir nur dem Zweck angemessene Daten.</p>
            <h6 id="übermittlung-personenbezogener-daten-in-drittstaaten">Übermittlung personenbezogener Daten in Drittstaaten</h6>
            <p>Eine Übermittlung personenbezogener Daten in Drittstaaten findet auf <a href="http://eudt2019.403.io/">http://eudt2019.403.io</a> nicht statt.</p>
            <h6 id="dauer-der-speicherung">Dauer der Speicherung</h6>
            <p>Grundsätzlich löschen wir personenbezogene Daten nach dem Wegfall des Verarbeitungszwecks oder mit dem Ende einer gesetzlichen Nachweis- und Aufbewahrungsfrist.</p>
            <p>Sind die Daten für die Erfüllung vertraglicher oder gesetzlicher Pflichten nicht mehr erforderlich, werden diese regelmäßig gelöscht, es sei denn, deren – befristete – Weiterverarbeitung ist erforderlich zu folgenden Zwecken:</p>
            <ul class="incremental">
            <li><blockquote>
            <p>Erhaltung von Beweismitteln im Rahmen der gesetzlichen Verjährungsvorschriften. Nach den §§ 195 ff des Bürgerlichen Gesetzbuches (BGB) können diese Verjährungsfristen bis zu 30 Jahre betragen, wobei die regelmäßige Verjährungsfrist 3 Jahre beträgt.</p>
            </blockquote></li>
            </ul>
            <h6 id="rechte-der-betroffenen-person">Rechte der betroffenen Person</h6>
            <p>Werden personenbezogene Daten Ihrer Person verarbeitet, sind Sie Betroffener i.S.d. DS-GVO und es stehen Ihnen folgende Rechte gegenüber dem Verantwortlichen zu:</p>
            <h6 id="recht-auf-auskunft">Recht auf Auskunft</h6>
            <p>Sie können von dem Verantwortlichen eine Bestätigung darüber verlangen, ob personenbezogene Daten, die Sie betreffen, von uns verarbeitet werden.</p>
            <p>Liegt eine solche Verarbeitung vor, können Sie von dem Verantwortlichen über folgende Informationen Auskunft verlangen:</p>
            <blockquote>
            <p>(1) die Zwecke, zu denen die personenbezogenen Daten verarbeitet werden;</p>
            <p>(2) die Kategorien von personenbezogenen Daten, welche verarbeitet werden;</p>
            <p>(3) die Empfänger bzw. die Kategorien von Empfängern, gegenüber denen die Sie betreffenden personenbezogenen Daten offengelegt wurden oder noch offengelegt werden;</p>
            <p>(4) die geplante Dauer der Speicherung der Sie betreffenden personenbezogenen Daten oder, falls konkrete Angaben hierzu nicht möglich sind, Kriterien für die Festlegung der Speicherdauer;</p>
            <p>(5) alle verfügbaren Informationen über die Herkunft der Daten, wenn die personenbezogenen Daten nicht bei der betroffenen Person erhoben werden;</p>
            <p>(6) das Bestehen einer automatisierten Entscheidungsfindung einschließlich Profiling gemäß Art. 22 Abs. 1 und 4 DS-GVO und – zumindest in diesen Fällen – aussagekräftige Informationen über die involvierte Logik sowie die Tragweite und die angestrebten Auswirkungen einer derartigen Verarbeitung für die betroffene Person.</p>
            <p>(7) ob die Sie betreffenden personenbezogenen Daten in ein Drittland oder an eine internationale Organisation übermittelt werden. In diesem Zusammenhang können Sie verlangen, über die geeigneten Garantien gem. Art. 46 DS-GVO im Zusammenhang mit der Übermittlung unterrichtet zu werden.</p>
            </blockquote>
            <h6 id="recht-auf-berichtigung">Recht auf Berichtigung</h6>
            <p>Sie haben ein Recht auf Berichtigung und/oder Vervollständigung gegenüber dem Verantwortlichen, sofern die verarbeiteten personenbezogenen Daten, die Sie betreffen, unrichtig oder unvollständig sind. Der Verantwortliche hat die Berichtigung unverzüglich vorzunehmen.</p>
            <h6 id="recht-auf-einschränkung-der-verarbeitung">Recht auf Einschränkung der Verarbeitung</h6>
            <p>Unter den folgenden Voraussetzungen können Sie die Einschränkung der Verarbeitung der Sie betreffenden personenbezogenen Daten verlangen:</p>
            <blockquote>
            <p>(1) wenn Sie die Richtigkeit der Sie betreffenden personenbezogenen für eine Dauer bestreiten, die es dem Verantwortlichen ermöglicht, die Richtigkeit der personenbezogenen Daten zu überprüfen;</p>
            <p>(2) die Verarbeitung unrechtmäßig ist und Sie die Löschung der personenbezogenen Daten ablehnen und stattdessen die Einschränkung der Nutzung der personenbezogenen Daten verlangen;</p>
            <p>(3) der Verantwortliche die personenbezogenen Daten für die Zwecke der Verarbeitung nicht länger benötigt, Sie diese jedoch zur Geltendmachung, Ausübung oder Verteidigung von Rechtsansprüchen benötigen, oder</p>
            <p>(4) wenn Sie Widerspruch gegen die Verarbeitung gemäß Art. 21 Abs. 1 DS-GVO eingelegt haben und noch nicht feststeht, ob die berechtigten Gründe des Verantwortlichen gegenüber Ihren Gründen überwiegen.</p>
            </blockquote>
            <p>Wurde die Verarbeitung der Sie betreffenden personenbezogenen Daten eingeschränkt, dürfen diese Daten – von ihrer Speicherung abgesehen – nur mit Ihrer Einwilligung oder zur Geltendmachung, Ausübung oder Verteidigung von Rechtsansprüchen oder zum Schutz der Rechte einer anderen natürlichen oder juristischen Person oder aus Gründen eines wichtigen öffentlichen Interesses der Union oder eines Mitgliedstaats verarbeitet werden.</p>
            <p>Wurde die Einschränkung der Verarbeitung nach den o.g. Voraussetzungen eingeschränkt, werden Sie von dem Verantwortlichen unterrichtet bevor die Einschränkung aufgehoben wird.</p>
            <h6 id="recht-auf-löschung">Recht auf Löschung</h6>
            <h6 id="löschpflicht"> Löschpflicht</h6>
            <p>Sie können von dem Verantwortlichen verlangen, dass die Sie betreffenden personenbezogenen Daten unverzüglich gelöscht werden, und der Verantwortliche ist verpflichtet, diese Daten unverzüglich zu löschen, sofern einer der folgenden Gründe zutrifft:</p>
            <blockquote>
            <p>(1) Die Sie betreffenden personenbezogenen Daten sind für die Zwecke, für die sie erhoben oder auf sonstige Weise verarbeitet wurden, nicht mehr notwendig.</p>
            <p>(2) Sie widerrufen Ihre Einwilligung, auf die sich die Verarbeitung gem. Art. 6 Abs. 1 lit. a oder Art. 9 Abs. 2 lit. a DS-GVO stützte, und es fehlt an einer anderweitigen Rechtsgrundlage für die Verarbeitung.</p>
            <p>(3) Sie legen gem. Art. 21 Abs. 1 DS-GVO Widerspruch gegen die Verarbeitung ein und es liegen keine vorrangigen berechtigten Gründe für die Verarbeitung vor, oder Sie legen gem. Art. 21 Abs. 2 DS-GVO Widerspruch gegen die Verarbeitung ein.</p>
            <p>(4) Die Sie betreffenden personenbezogenen Daten wurden unrechtmäßig verarbeitet.</p>
            <p>(5) Die Löschung der Sie betreffenden personenbezogenen Daten ist zur Erfüllung einer rechtlichen Verpflichtung nach dem Unionsrecht oder dem Recht der Mitgliedstaaten erforderlich, dem der Verantwortliche unterliegt.</p>
            <p>(6) Die Sie betreffenden personenbezogenen Daten wurden in Bezug auf angebotene Dienste der Informationsgesellschaft gemäß Art. 8 Abs. 1 DS-GVO erhoben.</p>
            </blockquote>
            <h6 id="information-an-dritte"> Information an Dritte</h6>
            <p>Hat der Verantwortliche die Sie betreffenden personenbezogenen Daten öffentlich gemacht und ist er gem. Art. 17 Abs. 1 DS-GVO zu deren Löschung verpflichtet, so trifft er unter Berücksichtigung der verfügbaren Technologie und der Implementierungskosten angemessene Maßnahmen, auch technischer Art, um für die Datenverarbeitung Verantwortliche, die die personenbezogenen Daten verarbeiten, darüber zu informieren, dass Sie als betroffene Person von ihnen die Löschung aller Links zu diesen personenbezogenen Daten oder von Kopien oder Replikationen dieser personenbezogenen Daten verlangt haben.</p>
            <h6 id="ausnahmen"> Ausnahmen</h6>
            <p>Das Recht auf Löschung besteht nicht, soweit die Verarbeitung erforderlich ist</p>
            <blockquote>
            <p>(1) zur Ausübung des Rechts auf freie Meinungsäußerung und Information;</p>
            <p>(2) zur Erfüllung einer rechtlichen Verpflichtung, die die Verarbeitung nach dem Recht der Union oder der Mitgliedstaaten, dem der Verantwortliche unterliegt, erfordert, oder zur Wahrnehmung einer Aufgabe, die im öffentlichen Interesse liegt oder in Ausübung öffentlicher Gewalt erfolgt, die dem Verantwortlichen übertragen wurde;</p>
            <p>(3) aus Gründen des öffentlichen Interesses im Bereich der öffentlichen Gesundheit gemäß Art. 9 Abs. 2 lit. h und i sowie Art. 9 Abs. 3 DS-GVO;</p>
            <p>(4) für im öffentlichen Interesse liegende Archivzwecke, wissenschaftliche oder historische Forschungszwecke oder für statistische Zwecke gem. Art. 89 Abs. 1 DS-GVO, soweit das unter Abschnitt a) genannte Recht voraussichtlich die Verwirklichung der Ziele dieser Verarbeitung unmöglich macht oder ernsthaft beeinträchtigt, oder</p>
            <p>(5) zur Geltendmachung, Ausübung oder Verteidigung von Rechtsansprüchen.</p>
            </blockquote>
            <h6 id="recht-auf-unterrichtung">Recht auf Unterrichtung</h6>
            <p>Haben Sie das Recht auf Berichtigung, Löschung oder Einschränkung der Verarbeitung gegenüber dem Verantwortlichen geltend gemacht, ist dieser verpflichtet, allen Empfängern, denen die Sie betreffenden personenbezogenen Daten offengelegt wurden, diese Berichtigung oder Löschung der Daten oder Einschränkung der Verarbeitung mitzuteilen, es sei denn, dies erweist sich als unmöglich oder ist mit einem unverhältnismäßigen Aufwand verbunden.</p>
            <p>Ihnen steht gegenüber dem Verantwortlichen das Recht zu, über diese Empfänger unterrichtet zu werden.</p>
            <h6 id="recht-auf-datenübertragbarkeit">Recht auf Datenübertragbarkeit</h6>
            <p>Sie haben das Recht, die Sie betreffenden personenbezogenen Daten, die Sie dem Verantwortlichen bereitgestellt haben, in einem strukturierten, gängigen und maschinenlesbaren Format zu erhalten. Außerdem haben Sie das Recht diese Daten einem anderen Verantwortlichen ohne Behinderung durch den Verantwortlichen, dem die personenbezogenen Daten bereitgestellt wurden, zu übermitteln, sofern</p>
            <blockquote>
            <p>(1) die Verarbeitung auf einer Einwilligung gem. Art. 6 Abs. 1 lit. a DS-GVO oder Art. 9 Abs. 2 lit. a DS-GVO oder auf einem Vertrag gem. Art. 6 Abs. 1 lit. b DS-GVO beruht und</p>
            <p>(2) die Verarbeitung mithilfe automatisierter Verfahren erfolgt.</p>
            </blockquote>
            <p>In Ausübung dieses Rechts haben Sie ferner das Recht, zu erwirken, dass die Sie betreffenden personenbezogenen Daten direkt von einem Verantwortlichen einem anderen Verantwortlichen übermittelt werden, soweit dies technisch machbar ist. Freiheiten und Rechte anderer Personen dürfen hierdurch nicht beeinträchtigt werden.</p>
            <p>Das Recht auf Datenübertragbarkeit gilt nicht für eine Verarbeitung personenbezogener Daten, die für die Wahrnehmung einer Aufgabe erforderlich ist, die im öffentlichen Interesse liegt oder in Ausübung öffentlicher Gewalt erfolgt, die dem Verantwortlichen übertragen wurde.</p>
            <h6 id="recht-auf-widerspruch">Recht auf Widerspruch</h6>
            <p>Sie haben das Recht, aus Gründen, die sich aus ihrer besonderen Situation ergeben, jederzeit gegen die Verarbeitung der Sie betreffenden personenbezogenen Daten, die aufgrund von Art. 6 Abs. 1 lit. e oder f DS-GVO erfolgt, Widerspruch einzulegen; dies gilt auch für ein auf diese Bestimmungen gestütztes Profiling. Der Verantwortliche verarbeitet die Sie betreffenden personenbezogenen Daten nicht mehr, es sei denn, er kann zwingende schutzwürdige Gründe für die Verarbeitung nachweisen, die Ihre Interessen, Rechte und Freiheiten überwiegen, oder die Verarbeitung dient der Geltendmachung, Ausübung oder Verteidigung von Rechtsansprüchen.</p>
            <p>Werden die Sie betreffenden personenbezogenen Daten verarbeitet, um Direktwerbung zu betreiben, haben Sie das Recht, jederzeit Widerspruch gegen die Verarbeitung der Sie betreffenden personenbezogenen Daten zum Zwecke derartiger Werbung einzulegen; dies gilt auch für das Profiling, soweit es mit solcher Direktwerbung in Verbindung steht.</p>
            <p>Widersprechen Sie der Verarbeitung für Zwecke der Direktwerbung, so werden die Sie betreffenden personenbezogenen Daten nicht mehr für diese Zwecke verarbeitet.</p>
            <p>Sie haben die Möglichkeit, im Zusammenhang mit der Nutzung von Diensten der Informationsgesellschaft – ungeachtet der Richtlinie 2002/58/EG – Ihr Widerspruchsrecht mittels automatisierter Verfahren auszuüben, bei denen technische Spezifikationen verwendet werden.</p>
            <h6 id="recht-auf-widerruf-der-datenschutzrechtlichen-einwilligungserklärung">Recht auf Widerruf der datenschutzrechtlichen Einwilligungserklärung</h6>
            <p>Sofern die Verarbeitung Ihrer personenbezogenen Daten auf einer Einwilligung beruht, können Sie Ihre Einwilligung zur Verarbeitung jederzeit mit Wirkung für die Zukunft widerrufen. Die betreffenden Daten werden dann umgehend, im Abgleich mit gesetzlichen Speicherfristen, gesperrt bzw. gelöscht.</p>
            <p>Durch den Widerruf der Einwilligung wird die Rechtmäßigkeit, der aufgrund der Einwilligung bis zum Widerruf erfolgten Verarbeitung, nicht berührt.</p>
            <p>Ihren Widerruf können Sie auf gleichem Weg wie Ihre Einwilligung durchführen. Alternativ können Sie sich unter Angabe Ihres vollständigen Namens und Ihrer E-Mail-Adresse an folgende Post- oder E-Mail-Adresse wenden:</p>
            <blockquote>
            <p>Feld M GmbH</p>
            <p>– Datenschutz –</p>
            <p>Sandstraße 33</p>
            <p>80335 München</p>
            <p>Tel +49 (0) 89 / 60807600</p>
            <p>datenschutz@feld-m.de</p>
            </blockquote>
            <h6 id="ausschlussrecht-in-automatisierter-entscheidung-im-einzelfall-einschließlich-profiling">Ausschlussrecht in automatisierter Entscheidung im Einzelfall, einschließlich Profiling</h6>
            <p>Sie haben das Recht, nicht einer ausschließlich auf einer automatisierten Verarbeitung – einschließlich Profiling – beruhenden Entscheidung unterworfen zu werden, die Ihnen gegenüber rechtliche Wirkung entfaltet oder Sie in ähnlicher Weise erheblich beeinträchtigt. Dies gilt nicht, wenn die Entscheidung</p>
            <blockquote>
            <p>(1) für den Abschluss oder die Erfüllung eines Vertrags zwischen Ihnen und dem Verantwortlichen erforderlich ist,</p>
            <p>(2) aufgrund von Rechtsvorschriften der Union oder der Mitgliedstaaten, denen der Verantwortliche unterliegt, zulässig ist und diese Rechtsvorschriften angemessene Maßnahmen zur Wahrung Ihrer Rechte und Freiheiten sowie Ihrer berechtigten Interessen enthalten oder</p>
            <p>(3) mit Ihrer ausdrücklichen Einwilligung erfolgt.</p>
            </blockquote>
            <p>Allerdings dürfen diese Entscheidungen nicht auf besonderen Kategorien personenbezogener Daten nach Art. 9 Abs. 1 DS-GVO beruhen, sofern nicht Art. 9 Abs. 2 lit. a oder g DS-GVO gilt und angemessene Maßnahmen zum Schutz der Rechte und Freiheiten sowie Ihrer berechtigten Interessen getroffen wurden.</p>
            <p>Hinsichtlich der in (1) und (3) genannten Fälle trifft der Verantwortliche angemessene Maßnahmen, um die Rechte und Freiheiten sowie Ihre berechtigten Interessen zu wahren, wozu mindestens das Recht auf Erwirkung des Eingreifens einer Person seitens des Verantwortlichen, auf Darlegung des eigenen Standpunkts und auf Anfechtung der Entscheidung gehört.</p>
            <h6 id="recht-auf-beschwerde-bei-einer-aufsichtsbehörde">Recht auf Beschwerde bei einer Aufsichtsbehörde</h6>
            <p>Unbeschadet eines anderweitigen verwaltungsrechtlichen oder gerichtlichen Rechtsbehelfs steht Ihnen das Recht auf Beschwerde bei einer Aufsichtsbehörde, insbesondere in dem Mitgliedstaat ihres Aufenthaltsorts, ihres Arbeitsplatzes oder des Orts des mutmaßlichen Verstoßes, zu, wenn Sie der Ansicht sind, dass die Verarbeitung der Sie betreffenden personenbezogenen Daten gegen die DS-GVO verstößt.</p>
            <p>Die Aufsichtsbehörde, bei der die Beschwerde eingereicht wurde, unterrichtet den Beschwerdeführer über den Stand und die Ergebnisse der Beschwerde einschließlich der Möglichkeit eines gerichtlichen Rechtsbehelfs nach Art. 78 DS-GVO.</p>
            <p>Eine Liste der Datenschutzbeauftragten sowie deren Kontaktdaten können folgendem Link entnommen werden:</p>
            <p><a href="https://www.bfdi.bund.de/DE/Infothek/Anschriften_Links/anschriften_links-node.html">https://www.bfdi.bund.de/DE/Infothek/Anschriften_Links/anschriften_links-node.html</a></p>
            <h6 id="bereitstellung-der-website-und-erstellung-von-logfiles">Bereitstellung der Website und Erstellung von Logfiles</h6>
            <h6 id="beschreibung-und-umfang-der-datenverarbeitung">Beschreibung und Umfang der Datenverarbeitung</h6>
            <p>Bei jedem Aufruf unserer Internetseite erfasst unser System automatisiert Daten und Informationen vom Computersystem des aufrufenden Rechners.</p>
            <p>Folgende Daten werden hierbei erhoben:</p>
            <ol class="incremental" type="1">
            <li><p>Browsertyp und Browserversion</p></li>
            <li><p>verwendetes Betriebssystem</p></li>
            <li><p>Referrer URL</p></li>
            <li><p>Unterwebseiten</p></li>
            <li><p>Hostname des zugreifenden Rechners</p></li>
            <li><p>Datum und Uhrzeit der Serveranfrage</p></li>
            <li><p>IP-Adresse</p></li>
            <li><p>Sprache</p></li>
            <li><p>Gerätetyp</p></li>
            </ol>
            <p>Eine Zusammenführung dieser Daten mit anderen Datenquellen wird nicht vorgenommen.</p>
            <p>Die Daten werden ebenfalls in den Logfiles unseres Systems gespeichert. Eine Speicherung dieser Daten zusammen mit anderen personenbezogenen Daten des Nutzers findet nicht statt.</p>
            <h6 id="zweck-der-datenverarbeitung">Zweck der Datenverarbeitung</h6>
            <p>Die vorübergehende Speicherung der IP-Adresse durch das System ist notwendig, um eine Auslieferung der Website an den Rechner des Nutzers zu ermöglichen. Hierfür muss die IP-Adresse des Nutzers für die Dauer der Sitzung gespeichert bleiben.</p>
            <p>Die Speicherung in Logfiles erfolgt, um die Funktionsfähigkeit der Website sicherzustellen. Zudem dienen uns die Daten zur Optimierung der Website und zur Sicherstellung der Sicherheit unserer informationstechnischen Systeme. Eine Auswertung der Daten zu Marketingzwecken findet in diesem Zusammenhang nicht statt.</p>
            <h6 id="rechtsgrundlage-für-die-datenverarbeitung">Rechtsgrundlage für die Datenverarbeitung </h6>
            <p>Rechtsgrundlage für die vorübergehende Speicherung der Daten und der Logfiles ist Art. 6 Abs. 1 lit. f DS-GVO. Das berechtigte Interesse des Websitebetreibers liegt in der störungsfreien Bereitstellung der Website und des damit verbundenen Websiteangebots für die Nutzer.</p>
            <h6 id="dauer-der-speicherung-1">Dauer der Speicherung</h6>
            <p>Die Daten werden gelöscht, sobald sie für die Erreichung des Zweckes ihrer Erhebung nicht mehr erforderlich sind. Im Falle der Erfassung der Daten zur Bereitstellung der Website ist dies der Fall, wenn die jeweilige Sitzung beendet ist.</p>
            <p>Die Löschung erfolgt spätestens nach 9 Wochen durch unseren Servicedienstleister.</p>
            <h6 id="widerspruchs--und-beseitigungsmöglichkeit">Widerspruchs- und Beseitigungsmöglichkeit</h6>
            <p>Die Erfassung der Daten zur Bereitstellung der Website und die Speicherung der Daten in Logfiles ist für den Betrieb der Internetseite zwingend erforderlich. Es besteht folglich seitens des Nutzers keine Widerspruchsmöglichkeit.</p>
            <h6 id="verwendung-von-cookies">Verwendung von Cookies</h6>
            <p>Unsere Website verwendet zurzeit keine Cookies.</p>
            <h6 id="externe-links">Externe Links</h6>
            <p>Unsere Internetseite enthält Links auf externe Seiten wie zum Beispiel zu Open Streetmaps oder zu Leaflet, einer JavaScript Library für die Bereitstellung interaktiver Karten.</p>
            <h6 id="begriffsbestimmungen">Begriffsbestimmungen</h6>
            <p>Die Datenschutzerklärung der FELD M GmbH/<a href="http://eudt2019.403.io/">http://eudt2019.403.io</a> beruht auf den Begrifflichkeiten, die durch den Europäischen Richtlinien- und Verordnungsgeber beim Erlass der Datenschutz-Grundverordnung (DS-GVO) verwendet wurden. Unsere Datenschutzerklärung soll sowohl für die Öffentlichkeit als auch für unsere Kunden und Geschäftspartner einfach lesbar und verständlich sein. Um dies zu gewährleisten, möchten wir vorab die verwendeten Begrifflichkeiten erläutern.</p>
            <p>Wir verwenden in dieser Datenschutzerklärung unter anderem die folgenden Begriffe:</p>
            <h6 id="personenbezogene-daten">personenbezogene Daten</h6>
            <p>Personenbezogene Daten sind alle Informationen, die sich auf eine identifizierte oder identifizierbare natürliche Person (im Folgenden „betroffene Person“) beziehen. Als identifizierbar wird eine natürliche Person angesehen, die direkt oder indirekt, insbesondere mittels Zuordnung zu einer Kennung wie einem Namen, zu einer Kennnummer, zu Standortdaten, zu einer Online-Kennung oder zu einem oder mehreren besonderen Merkmalen, die Ausdruck der physischen, physiologischen, genetischen, psychischen, wirtschaftlichen, kulturellen oder sozialen Identität dieser natürlichen Person sind, identifiziert werden kann.</p>
            <h6 id="betroffene-person">betroffene Person</h6>
            <p>Betroffene Person ist jede identifizierte oder identifizierbare natürliche Person, deren personenbezogene Daten von dem für die Verarbeitung Verantwortlichen verarbeitet werden.</p>
            <h6 id="verarbeitung">Verarbeitung</h6>
            <p>Verarbeitung ist jeder mit oder ohne Hilfe automatisierter Verfahren ausgeführte Vorgang oder jede solche Vorgangsreihe im Zusammenhang mit personenbezogenen Daten wie das Erheben, das Erfassen, die Organisation, das Ordnen, die Speicherung, die Anpassung oder Veränderung, das Auslesen, das Abfragen, die Verwendung, die Offenlegung durch Übermittlung, Verbreitung oder eine andere Form der Bereitstellung, den Abgleich oder die Verknüpfung, die Einschränkung, das Löschen oder die Vernichtung.</p>
            <h6 id="einschränkung-der-verarbeitung">Einschränkung der Verarbeitung</h6>
            <p>Einschränkung der Verarbeitung ist die Markierung gespeicherter personenbezogener Daten mit dem Ziel, ihre künftige Verarbeitung einzuschränken.</p>
            <h6 id="profiling">Profiling</h6>
            <p>Profiling ist jede Art der automatisierten Verarbeitung personenbezogener Daten, die darin besteht, dass diese personenbezogenen Daten verwendet werden, um bestimmte persönliche Aspekte, die sich auf eine natürliche Person beziehen, zu bewerten, insbesondere, um Aspekte bezüglich Arbeitsleistung, wirtschaftlicher Lage, Gesundheit, persönlicher Vorlieben, Interessen, Zuverlässigkeit, Verhalten, Aufenthaltsort oder Ortswechsel dieser natürlichen Person zu analysieren oder vorherzusagen.</p>
            <h6 id="pseudonymisierung">Pseudonymisierung</h6>
            <p>Pseudonymisierung ist die Verarbeitung personenbezogener Daten in einer Weise, auf welche die personenbezogenen Daten ohne Hinzuziehung zusätzlicher Informationen nicht mehr einer spezifischen betroffenen Person zugeordnet werden können, sofern diese zusätzlichen Informationen gesondert aufbewahrt werden und technischen und organisatorischen Maßnahmen unterliegen, die gewährleisten, dass die personenbezogenen Daten nicht einer identifizierten oder identifizierbaren natürlichen Person zugewiesen werden.</p>
            <h6 id="verantwortlicher-oder-für-die-verarbeitung-verantwortlicher">Verantwortlicher oder für die Verarbeitung Verantwortlicher</h6>
            <p>Verantwortlicher oder für die Verarbeitung Verantwortlicher ist die natürliche oder juristische Person, Behörde, Einrichtung oder andere Stelle, die allein oder gemeinsam mit anderen über die Zwecke und Mittel der Verarbeitung von personenbezogenen Daten entscheidet. Sind die Zwecke und Mittel dieser Verarbeitung durch das Unionsrecht oder das Recht der Mitgliedstaaten vorgegeben, so kann der Verantwortliche beziehungsweise können die bestimmten Kriterien seiner Benennung nach dem Unionsrecht oder dem Recht der Mitgliedstaaten vorgesehen werden.</p>
            <h6 id="auftragsverarbeiter">Auftragsverarbeiter</h6>
            <p>Auftragsverarbeiter ist eine natürliche oder juristische Person, Behörde, Einrichtung oder andere Stelle, die personenbezogene Daten im Auftrag des Verantwortlichen verarbeitet.</p>
            <h6 id="empfänger">Empfänger</h6>
            <p>Empfänger ist eine natürliche oder juristische Person, Behörde, Einrichtung oder andere Stelle, der personenbezogene Daten offengelegt werden, unabhängig davon, ob es sich bei ihr um einen Dritten handelt oder nicht. Behörden, die im Rahmen eines bestimmten Untersuchungsauftrags nach dem Unionsrecht oder dem Recht der Mitgliedstaaten möglicherweise personenbezogene Daten erhalten, gelten jedoch nicht als Empfänger.</p>
            <h6 id="dritter">Dritter</h6>
            <p>Dritter ist eine natürliche oder juristische Person, Behörde, Einrichtung oder andere Stelle außer der betroffenen Person, dem Verantwortlichen, dem Auftragsverarbeiter und den Personen, die unter der unmittelbaren Verantwortung des Verantwortlichen oder des Auftragsverarbeiters befugt sind, die personenbezogenen Daten zu verarbeiten.</p>
            <h6 id="einwilligung">Einwilligung</h6>
            <p>Einwilligung ist jede von der betroffenen Person freiwillig für den bestimmten Fall in informierter Weise und unmissverständlich abgegebene Willensbekundung in Form einer Erklärung oder einer sonstigen eindeutigen bestätigenden Handlung, mit der die betroffene Person zu verstehen gibt, dass sie mit der Verarbeitung der sie betreffenden personenbezogenen Daten einverstanden ist.</p>

          </div>

          <div v-if="this.$i18n.locale === 'en'" class="column col-12">
            <h2 id="imprintlegal-info">Imprint/Legal info:</h2>
            <p>FELD M GmbH<br />
            Sandstraße 33<br />
            80335 München</p>
            <p>phone +49.89.5529756.0<br />
            fax +49.89.5529756.22<br />
            e-Mail <a href="mailto:contact@feld-m.de">contact@feld-m.de</a></p>
            <p><strong>Legal Form:</strong><br />
            Limited Liability Company (Gesellschaft mit beschränkter Haftung)</p>
            <p><strong>Place of business:</strong><br />
            München</p>
            <p><strong>Registration court:</strong><br />
            Amtsgericht München<br />
            HRB 145976</p>
            <p><strong>Director:</strong><br />
            Lutz Wiechert, Dipl. Kfm.</p>
            <p><strong>Tax ID number:</strong><br />
            DE226898258</p>

            <h2 id="privacy-policy-for-httpeudt2019.403.io">Privacy Policy for <a href="http://eudt2019.403.io/">http://eudt2019.403.io</a></h2>
            <h6 id="information-to-be-provided-where-personal-data-are-collected-on-the-httpeudt2019.403.io-website-article-13-general-data-protection-regulation-gdpr">Information to be provided where personal data are collected on the <a href="http://eudt2019.403.io/">http://eudt2019.403.io</a> website<br />
            (Article 13 General Data Protection Regulation (GDPR))</h6>
            <h6 id="general-information-about-data-processing">General information about data processing</h6>
            <h6 id="name-and-address-of-the-controller">Name and address of the controller:</h6>
            <p> </p>
            <p>The controller within the meaning of the General Data Protection Regulation and other national data protection laws of the EU Member States as well as other data protection regulations is:</p>
            <blockquote>
            <p>FELD M GmbH</p>
            <p>Sandstraße 33</p>
            <p>80335 Munich</p>
            <p>Germany</p>
            <p>Phone: +49.89.5529756.0</p>
            <p>Fax: +49.89.5529756.22</p>
            <p>Managing Director: Lutz Wiechert</p>
            <p><a href="mailto:contact@feld-m.de">contact@feld-m.de</a></p>
            </blockquote>
            <p><a href="https://www.feld-m.de/">https://www.feld-m.de/</a></p>
            <h6 id="data-protection-officers-contact-details">Data protection officer’s contact details</h6>
            <p>The data protection officer responsible for compliance with the General Data Protection Regulation and supplementary data protection regulations is:</p>
            <blockquote>
            <p>Feld M GmbH</p>
            <p>– Datenschutz –</p>
            <p>Sandstraße 33</p>
            <p>80335 Munich</p>
            <p>Germany</p>
            <p>Phone: +49 (0) 89 / 60807600</p>
            </blockquote>
            <p>datenschutz@feld-m.de</p>
            <p> </p>
            <h6 id="recipients-of-the-collected-data">Recipients of the collected data</h6>
            <p>At http://eudt2019.403.io, no data is collected for evaluation purposes and is addressed to groups of persons for processing. In this respect, there are no recipients of personal data.</p>
            <h6 id="extent-to-which-personal-data-is-processed">Extent to which personal data is processed</h6>
            <p>If we process personal data, we handle it in accordance with the provisions of the EU General Data Protection Regulation (GDPR) and the German Federal Data Protection Act (BDSG-new) on the basis of the following legal principles:</p>
            <blockquote>
            <p>(1) Article 6(1) point (b) GDPR<br />
            Personal data may be processed for the performance of a contract or pre-contractual measures.</p>
            <p>(2) Article 6(1) point (f) GDPR<br />
            The controller may process personal data to the extent required to safeguard its own legitimate interests.</p>
            </blockquote>
            <p>In accordance with legal requirements, we only collect data appropriate for the intended purpose.</p>
            <h6 id="transfer-of-personal-data-to-third-countries">Transfer of personal data to third countries</h6>
            <p>A transfer of personal data to third countries does not take place on http://eudt2019.403.io. </p>
            <h6 id="duration-of-storage">Duration of storage</h6>
            <p>We principally erase personal once it is no longer required for the processing purpose or on completion of any legal verification and retention period.</p>
            <p>If the data are no longer required for the performance of contractual or legal obligations, these are regularly erased unless their temporary processing is necessary for the following purposes:</p>
            <ul class="incremental">
            <li><p>Preservation of evidence in the context of the statutory statute of limitations. According to Section 195 ff of the German Civil Code (BGB), these limitation periods can be up to 30 years, whereby the standard period of limitation is 3 years.</p></li>
            </ul>
            <p> </p>
            <h6 id="rights-of-the-data-subject">Rights of the data subject</h6>
            <p>If personal data relating to you is processed, you are considered to be a data subject within the meaning of the GDPR and you have the following rights in respect to the controller:</p>
            <h6 id="right-of-access">Right of access</h6>
            <p>You have the right to obtain from the controller confirmation as to whether or not personal data relating to you is processed by us.</p>
            <p>If that is the case, you can request information from the controller about the following information:</p>
            <blockquote>
            <p>(1)       The purposes for which the personal data are processed;</p>
            <p>(2)       The categories of personal data being processed;</p>
            <p>(3)       The recipients or categories of recipients to whom the personal data relating to you have been or will be disclosed;</p>
            <p>(4)          The envisaged period for which the personal data will be stored, or, if not possible, the criteria used to determine that period;</p>
            <p>(5)          All available information on the source of the data if the personal data are not collected from the data subject;</p>
            <p>(6)          The existence of automated decision-making, including profiling, referred to in Article 22(1) and (4) GDPR and, at least in those cases, meaningful information about the logic involved, as well as the significance and the envisaged consequences of such processing for the data subject.</p>
            <p>(7)          Whether the personal data concerning you are transferred to a third country or to an international organisation. In this regard you have the right to be informed about appropriate safeguards pursuant to Article 46 relating to the transfer.</p>
            <p> </p>
            </blockquote>
            <h6 id="right-to-rectification">Right to rectification</h6>
            <p>You have the right to obtain from the controller the rectification and/or completion of personal data relating to you insofar that the processed personal data is incorrect or incomplete. The controller must make the rectification without undue delay.</p>
            <p> </p>
            <h6 id="right-to-restriction-of-processing">1.7.3. Right to restriction of processing</h6>
            <p>You may request the restriction of the processing of your personal data relating to you under the following conditions:</p>
            <blockquote>
            <p>(1)          You contest the accuracy of the personal data relating to you, for a period enabling the controller to verify the accuracy of the personal data;</p>
            <p>(2)          The processing is unlawful and you oppose the erasure of the personal data and request the restriction of their use instead;</p>
            <p>(3)          The controller no longer needs the personal data for the purposes of the processing, but you require it for the establishment, exercise or defence of legal claims; or</p>
            <p>(4)          You have objected to processing pursuant to Article 21(1) GDPR pending the verification whether the legitimate grounds of the controller override your reasons.</p>
            </blockquote>
            <p>If the processing of personal data relating to you has been restricted, this data – with the exception of storage – may only be processed with your consent or for the establishment, exercise or defence of legal claims, or for the protection of the rights of another natural or legal person, or for reasons of important public interest of the Union or of a Member State.</p>
            <p>If you have obtained restriction of processing in accordance with the above conditions, you will be notified by the controller before the restriction of processing is lifted.</p>
            <p> </p>
            <h6 id="right-to-erasure">Right to erasure</h6>
            <h6 id="a-erasure-obligation">a)  Erasure obligation</h6>
            <p>You can demand that the controller deletes your personal data relating to you without undue delay, and the controller shall have the obligation to erase this data without undue delay where one of the following grounds applies:</p>
            <blockquote>
            <p>(1)          The personal data relating to you are no longer necessary in relation to the purposes for which they were collected or otherwise processed.</p>
            <p>(2)          You withdraw consent on which the processing is based according to point (a) of Article 6(1), or point (a) of Article 9(2) GDPR, and there is no other legal ground for the processing.</p>
            <p>(3)          You object to the processing pursuant to Article 21(1) GDPR, and there are no overriding legitimate grounds for processing, or you object to the processing pursuant to Article 21(2) GDPR.</p>
            <p>(4)          The personal data relating to you have been processed unlawfully.</p>
            <p>(5)          The erasure of the personal data relating to you is required to fulfil a legal obligation under Union or Member State law, to which the controller is subject.</p>
            <p>(6)          The personal data relating to you have been collected in relation to the offer of information society services referred to in Article 8(1) GDPR.</p>
            </blockquote>
            <h6 id="b-information-to-third-parties">b)  Information to third parties</h6>
            <p>Where the controller has made the personal data public and is obligated to erase the personal data pursuant to Article 17(1) GDPR, the controller, taking available technology and the cost of implementation into account, shall take reasonable steps, including technical measures, to inform controllers which are processing the personal data that you, as the data subject, have requested the erasure by such controllers of any links to, or copy or replication of, those personal data.</p>
            <h6 id="c-exceptions">c)  Exceptions</h6>
            <p>The right to erasure does not apply to the extent that the processing is necessary</p>
            <blockquote>
            <p>(1)          for exercising the right of freedom of expression and information;</p>
            <p>(2)          for compliance with a legal obligation which requires processing by Union or Member State law to which the controller is subject or for the performance of a task carried out in the public interest or in exercising official authority vested in the controller;</p>
            <p>(3)          for reasons of public interest in the area of public health in accordance with points (h) and (i) of Article 9(2) as well as Article 9(3) GDPR;</p>
            <p>(4)          for archiving purposes in the public interest, scientific or historical research purposes or statistical purposes in accordance with Article 89(1) of the GDPR, in so far as the law referred to in subparagraph a) is likely to render impossible or seriously impair the achievement of the objectives of that processing, or</p>
            <p>(5)          for the establishment, exercise or defence of legal claims.</p>
            <p> </p>
            </blockquote>
            <h6 id="right-to-be-informed">Right to be informed</h6>
            <p>If you have exercised your right to obtain from the controller the rectification, erasure or restriction of processing, it is obliged to notify all recipients to whom your personal data have been disclosed about the rectification or erasure of the data or restriction of processing, unless this proves to be impossible or involves a disproportionate effort.</p>
            <p>You have the right to be informed by the controller about these recipients.</p>
            <h6 id="right-to-data-portability">Right to data portability</h6>
            <p>You have the right to receive the personal data concerning you, which you have provided to the controller, in a structured, commonly used and machine-readable format. In addition, you have the right to transmit those data to another controller without hindrance from the controller to whom the personal data have been provided, provided that</p>
            <blockquote>
            <p>(1) the processing is based on consent pursuant to point (a) of Article 6(1) GDPR or point (a) of Article 9(2) GDPR or is based on a contract pursuant to point (b) of Article 6(1) GDPR; and</p>
            <p>(2) the processing is carried out by automated means.</p>
            </blockquote>
            <p>In exercising this right you also have the right to have the personal data concerning you transmitted directly from one controller to another, provided that this is technically feasible. These rights should not adversely affect the rights and freedoms of others.</p>
            <p>The right to data portability does not apply to the processing of personal data necessary for the performance of a task carried out in the public interest or in exercising official authority vested in the controller.</p>
            <p> </p>
            <h6 id="right-to-object">Right to object</h6>
            <p>You have the right at any time, for reasons that arise from your particular situation, to object to the processing of personal data concerning you which is based on point (e) or (f) of Article 6(1) GDPR, including profiling based on those provisions. The controller will no longer process the personal data concerning you unless it can demonstrate compelling legitimate grounds for the processing which override your interests, rights and freedoms or for the establishment, exercise or defence of legal claims.</p>
            <p>If the personal data concerning you is processed for direct marketing purposes, you have the right to object at any time to the processing of your personal data for the purpose of such marketing; this also applies to profiling to the extent that it is related to such direct marketing.</p>
            <p>If you object to processing for direct marketing purposes, the personal data concerning you will no longer be processed for these purposes.</p>
            <p>In the context of the use of information society services, and notwithstanding Directive 2002/58/EC, you may exercise your right to object by automated means using technical specifications.</p>
            <p> </p>
            <h6 id="right-to-revoke-your-declaration-of-consent-concerning-data-privacy">Right to revoke your declaration of consent concerning data privacy</h6>
            <p>If the processing of your personal data is based on your consent, you may revoke your consent to processing at any time with future effect. The relevant data will then be blocked or erased immediately in accordance with legal storage periods.</p>
            <p>The revocation of consent does not affect the lawfulness of the processing carried out on the basis of the consent until the revocation.</p>
            <p>You can carry out your revocation in the same way as your consent. Alternatively you can send your revocation of consent, stating your full name and email address, to the following postal or email address:</p>
            <blockquote>
            <p>Feld M GmbH</p>
            <p>– Datenschutz –</p>
            <p>Sandstraße 33</p>
            <p>80335 Munich</p>
            <p>Germany</p>
            <p>Tel +49 (0) 89 / 60807600</p>
            <p>datenschutz@feld-m.de</p>
            <p> </p>
            </blockquote>
            <h6 id="exclusion-right-in-automated-decisions-on-a-case-by-case-basis-including-profiling">Exclusion right in automated decisions on a case-by-case basis, including profiling</h6>
            <p>You have the right not to be subjected to a decision based solely on automated processing – including profiling – that will have legal effect or similarly affect you in a similar manner. This does not apply if the decision</p>
            <blockquote>
            <p>(1) is required for the conclusion or performance of a contract between you and the controller,</p>
            <p>(2) is permitted by Union or Member State legislation to which the controller is subject, and where such legislation contains appropriate measures to safeguard your rights and freedoms and legitimate interests, or</p>
            <p>(3) is made with your express consent.</p>
            </blockquote>
            <p>However, these decisions must not be based on special categories of personal data pursuant to Article 9(1) GDPR, unless point (a) or (g) of Article 9(2) GDPR applies and reasonable measures have been taken to protect the rights and freedoms as well as your legitimate interests.</p>
            <p>With regard to the cases referred to in (1) and (3), the controller shall implement suitable measures to safeguard your rights and freedoms and legitimate interests, at least the right to obtain human intervention on the part of the controller, to express his or her point of view and to contest the decision.</p>
            <p> </p>
            <h6 id="right-to-complain-to-a-supervisory-authority">Right to complain to a supervisory authority</h6>
            <p>Without prejudice to any other administrative or judicial remedy, you have the right to complain to a supervisory authority, in particular in the Member State of your residence, place of work or place of alleged infringement, if you believe that the processing of the personal data concerning you infringes the GDPR.</p>
            <p>The supervisory authority to which the complaint has been submitted shall inform the complainant of the status and results of the complaint, including the possibility of a judicial remedy in accordance with Article 78 of the GDPR.</p>
            <p>A list of data protection officers and their contact details can be found on the following link:</p>
            <p><a href="https://www.bfdi.bund.de/DE/Infothek/Anschriften_Links/anschriften_links-node.html">https://www.bfdi.bund.de/DE/Infothek/Anschriften_Links/anschriften_links-node.html</a></p>
            <h6 id="provision-of-the-website-and-creation-of-log-files">Provision of the website and creation of log files</h6>
            <h6 id="description-and-scope-of-the-data-processing">Description and scope of the data processing</h6>
            <p>Each time our website is accessed, our system automatically collects data and information from the computer system of the accessing computer.</p>
            <p>The following data is collected in this regard:</p>
            <ol class="incremental" type="1">
            <li><p>Browser type and browser version</p></li>
            <li><p>Operating system used</p></li>
            <li><p>Referrer URL</p></li>
            <li><p>Subsites</p></li>
            <li><p>Host name of the computer accessing the site</p></li>
            <li><p>Time of the server request</p></li>
            <li><p>IP address</p></li>
            <li><p>Language</p></li>
            <li><p>Device type</p></li>
            </ol>
            <p>This data will not be merged with other data sources.</p>
            <p>The data is also stored in our system’s log files. This data is not stored together with the user’s other personal data.</p>
            <p>  </p>
            <h6 id="purpose-of-the-data-processing">Purpose of the data processing</h6>
            <p>The temporary storage of the IP address by the system is necessary to enable delivery of the website to the user’s computer. To achieve this, the user’s IP address must be stored for the duration of the session.</p>
            <p>Data is stored in log files to ensure the functionality of the website. In addition, the data is used to optimise the website and to ensure the security of our information technology systems. An evaluation of the data for marketing purposes does not take place in this context.</p>
            <h6 id="legal-basis-for-data-processing">Legal basis for data processing</h6>
            <p>The legal basis for the temporary storage of data and log files is Article 6(1) point (f) GDPR. The legitimate interest of the website operator lies in the trouble-free provision of the website and the associated website services for users.</p>
            <h6 id="duration-of-storage-1">Duration of storage</h6>
            <p>The data will be erased as soon as it is no longer necessary for the purpose of its collection. In the case of collecting the data for providing the website, this is the case when the respective session is completed.</p>
            <p>The data is erased after 14 days. The service provider uses script-based deletion.</p>
            <h6 id="means-of-objection-and-termination">Means of objection and termination</h6>
            <p>The collection of data for providing the website and the storage of data in log files is absolutely imperative for operating the website. Users therefore do not have any possibility to object.</p>
            <h6 id="use-of-cookies">Use of cookies</h6>
            <p>Our website does not currently use cookies.</p>
            <ol class="incremental" start="4" type="1">
            <li><h6 id="external-linking"> External Linking</h6></li>
            <li><h6 id="our-website-contains-links-to-external-sites-such-as-open-streetmaps-or-leaflet-a-javascript-library-for-providing-interactive-maps.">Our website contains links to external sites such as Open Streetmaps or Leaflet, a JavaScript library for providing interactive maps.</h6></li>
            <li><h6 id="definitions">Definitions</h6></li>
            </ol>
            <p>FELD M GmbH/<a href="http://eudt2019.403.io/">http://eudt2019.403.io</a> Privacy Policy is based on the terminology used by the European legislative and regulatory bodies in adopting the EU General Data Protection Regulation (GDPR). Our Privacy Policy should be easy to read and understand for the public as well as for our customers and business partners. To ensure this, we would like to first of all explain the terminology used.</p>
            <p>Among others we use the following terms in this Privacy Policy:</p>
            <h6 id="personal-data">Personal data</h6>
            <p>Personal data means any information relating to an identified or identifiable natural person (hereinafter the “data subject”). An identifiable natural person is one who can be identified, directly or indirectly, in particular by reference to an identifier such as a name, an identification number, location data, an online identifier or to one or more factors specific to the physical, physiological, genetic, mental, economic, cultural or social identity of that natural person.</p>
            <h6 id="data-subject">Data subject</h6>
            <p>A data subject is any identified or identifiable natural person whose personal data is processed by the controller.</p>
            <h6 id="processing">Processing</h6>
            <p>Processing means any operation or set of operations which is performed on personal data or on sets of personal data, whether or not by automated means, such as collection, recording, organisation, structuring, storage, adaptation or alteration, retrieval, consultation, use, disclosure by transmission, dissemination or otherwise making available, alignment or combination, restriction, erasure or destruction.</p>
            <h6 id="restriction-of-processing">Restriction of processing</h6>
            <p>Restriction of processing means the marking of stored personal data with the aim of limiting their processing in the future.</p>
            <h6 id="profiling">Profiling</h6>
            <p>Profiling means any form of automated processing of personal data consisting of the use of personal data to evaluate certain personal aspects relating to a natural person, in particular to analyse or predict aspects concerning that natural person’s performance at work, economic situation, health, personal preferences, interests, reliability, behaviour, location or movements.</p>
            <h6 id="pseudonymisation">Pseudonymisation</h6>
            <p>Pseudonymisation means the processing of personal data in such a manner that the personal data can no longer be attributed to a specific data subject without the use of additional information, provided that such additional information is kept separately and is subject to technical and organisational measures to ensure that the personal data are not attributed to an identified or identifiable natural person.</p>
            <h6 id="controller">Controller</h6>
            <p>Controller means the natural or legal person, public authority, agency or other body which, alone or jointly with others, determines the purposes and means of the processing of personal data. Where the purposes and means of such processing are determined by Union or Member State law, the controller or the specific criteria for its nomination may be provided for by Union or Member State law.</p>
            <h6 id="processor">Processor</h6>
            <p>Processor means a natural or legal person, public authority, agency or other body which processes personal data on behalf of the controller.</p>
            <h6 id="recipient">Recipient</h6>
            <p>Recipient means a natural or legal person, public authority, agency or another body, to which the personal data are disclosed, whether a third party or not. However, public authorities which may receive personal data in the framework of a particular inquiry in accordance with Union or Member State law shall not be regarded as recipients.</p>
            <h6 id="third-party">Third party</h6>
            <p>Third party means a natural or legal person, public authority, agency or body other than the data subject, controller, processor and persons who, under the direct authority of the controller or processor, are authorised to process personal data.</p>
            <h6 id="consent">Consent</h6>
            <p>Consent of the data subject means any freely given, specific, informed and unambiguous indication of the data subject’s wishes by which he or she, by a statement or by a clear affirmative action, signifies agreement to the processing of personal data relating to him or her.</p>

          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  mounted() {
    this.$parent.$data.modalOpen = true;
  },

  methods: {
    changeLocale(locale) {
      this.$i18n.locale = locale;
    },

    modalClose() {
      this.$router.push({ name: 'A01-EntryLanguageSelect' });
    },

    next(locale) {
      this.$parent.$data.modalOpen = false;
      this.$i18n.locale = locale;

      this.$router.push({ name: 'A02-EntryWelcome' });
    },
  },
};
</script>
