<%*
// Získání obsahu souboru a rozdělení na jednotlivé řádky
const lines = tp.file.content.split('\n');
let currentDate = '';

// Funkce pro převod datumu z formátu dd.mm.yy na YYYY-MM-DD
function convertDate(dateString) {
    const [day, month, year] = dateString.split('.');
    return `20${year}-${month}-${day}`; // Předpoklad, že rok je 20xx
}

// RegEx pro kontrolu jakéhokoliv data ve formátu YYYY-MM-DD se symbolem ➕
const dateWithPlusRegex = /➕ \d{4}-\d{2}-\d{2}/;

// Projde všechny řádky v dokumentu a aktualizuje je
const updatedLines = lines.map(line => {
    if (line.startsWith('## ')) {
        // Pokud najdeme nadpis s datem, vytáhneme datum
        const dateMatch = line.match(/\d{2}\.\d{2}\.\d{2}/);
        if (dateMatch) {
            currentDate = convertDate(dateMatch[0]);
        } else {
            // Pokud nenajdeme datum, vymažeme currentDate
            currentDate = '';
        }
    } else if (line.match(/- \[[ x]\]/) && currentDate) {
        // Pokud najdeme úkol a existuje platné datum, zkontrolujeme, jestli už nemá datum ve formátu YYYY-MM-DD se symbolem ➕
        if (!line.match(dateWithPlusRegex)) {
            // Pokud tam datum není, přidáme aktuální datum s ➕
            line += ` ➕ ${currentDate}`;
        }
    }
    return line;
});

// Nahrazení obsahu editoru aktualizovaným textem
const newContent = updatedLines.join('\n');
app.workspace.activeLeaf.view.sourceMode.cmEditor.setValue(newContent);
%>
