#define LIST_OF_CONSONANT_RU list("б","в","г","д","ж","з","й","к","л","м","н","п","р","с","т","ф","х","ц","ш","щ")

/stutter(n)
	var/te = html_decode(n)
	n = length(n)//length of the entire word
	var/list/t = list()
	var/p = 1//1 is the start of any word
	while(p <= n)//while P, which starts at 1 is less or equal to N which is the length.
		var/n_letter = copytext_char(te, p, p + 1)//copies text from a certain distance. In this case, only one letter at a time.
		if((lowertext(n_letter) in LIST_OF_CONSONANT|LIST_OF_CONSONANT_RU) && prob(80))
			n_letter = text("[n_letter]-[n_letter]")
		t += n_letter //since the above is ran through for each letter, the text just adds up back to the original word.
		p++//for each letter p is increased to find where the next letter will be.
	return sanitize(jointext(t, null))
