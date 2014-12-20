records = LOAD '$INPUT' USING PigStorage('\n') AS(
	tweet:chararray);

positive = LOAD '$INPUT2' USING PigStorage('\n') AS(
	pos_word);

negative = LOAD '$INPUT3' USING PigStorage('\n') AS(
	neg_word);

positives = FOREACH positive GENERATE
	pos_word,
	'positive';

negatives = FOREACH negative GENERATE
	neg_word,
	'negative';

updated = FOREACH records GENERATE
	(SUBSTRING(tweet,0,1)=='@' ? 1 : 0) as is_tweet,
	tweet;

filtered = FILTER updated BY is_tweet==1;

tweets = FOREACH filtered GENERATE
	tweet;

all_words = FOREACH tweets GENERATE FLATTEN(TOKENIZE(tweet)) as word;

grouped = GROUP all_words BY word;

joined_pos = JOIN grouped by group, positives by pos_word;

joined_neg = JOIN grouped by group, negatives by neg_word;

word_neg = FOREACH joined_neg GENERATE COUNT(all_words) as counts, group;

word_pos = FOREACH joined_pos GENERATE COUNT(all_words) as counts, group;

STORE word_neg INTO '$OUTPUT' USING PigStorage('\t');

STORE word_pos INTO '$OUTPUT2' USING PigStorage('\t');
