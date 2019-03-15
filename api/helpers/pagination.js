module.exports.getLinks = function(pages, totalLength, urlResolver) {
	let links = pages.getLinks(totalLength);

	if (links) {
		for (let [key, link] of Object.entries(links)) {
			links[key] = urlResolver.resolve(link);
		}

		return links;
	}
};
