const BREWERIES = {}

const handleResponse = (breweries) => {
    BREWERIES.list = breweries
    BREWERIES.sortByName()
    BREWERIES.show()
}

const createTableRow = (brewery) => {
    const tr = document.createElement("tr")
    tr.classList.add("tablerow")
    const breweryname = tr.appendChild(document.createElement("td"))
    breweryname.innerHTML = brewery.name
    const year = tr.appendChild(document.createElement("td"))
    year.innerHTML = "year: " + brewery.year
    const beers = tr.appendChild(document.createElement("td"))
    beers.innerHTML = "beers: "+ brewery.beers.length
    const active = tr.appendChild(document.createElement("td"))
    active.innerHTML = "Active: "+ brewery.active

    return tr
}

BREWERIES.show = () => {
    document.querySelectorAll(".tablerow").forEach((el) => el.remove())
    const table = document.getElementById("brewerylist")

    BREWERIES.list.forEach((brewery) => {
        const tr = createTableRow(brewery)
        table.appendChild(tr)
    })
}

BREWERIES.sortByName = () => {
    BREWERIES.list.sort((a, b) => {
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase())
    })
}

BREWERIES.sortByYear = () => {
    BREWERIES.list.sort((a, b) => {
        return a.year-b.year
    })
}

BREWERIES.sortByBeerCount = () => {
    BREWERIES.list.sort((a, b) => {
        return b.beers.length - a.beers.length
    })
}

const breweries = async () => {
    if (document.querySelectorAll("#brewerydiv").length < 1) return;

    document.getElementById("name").addEventListener("click", (e) => {
        e.preventDefault
        BREWERIES.sortByName()
        BREWERIES.show()
    })

    document.getElementById("year").addEventListener("click", (e) => {
        e.preventDefault
        BREWERIES.sortByYear()
        BREWERIES.show()
    })


    document.getElementById("beers").addEventListener("click", (e) => {
        e.preventDefault
        BREWERIES.sortByBeerCount()
        BREWERIES.show()
    })


    const response = await fetch("breweries.json") 
    handleResponse(await response.json())
}


export {breweries}