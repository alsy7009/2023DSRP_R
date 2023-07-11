library(dplyr)
data <- read.csv("data/dataset_breastcancer.csv")
names(data)
# filter observations of dataset using filter(): post-menopause and tested positive for breast cancer
meno_status <- filter(data, meno==1, status==1)

# smaller dataset with subset of vars using select(): menopause status through estrogen receptors
meno_to_er <- select(data, meno:er)

# add 2 new columns using mutate(): size/grade and rfstime/size
data_stats <- mutate(data,
                     size_by_grade = size/grade,
                     rfstime_by_size = rfstime/size)

# data table of grouped summaries: avg rfstime by grade
data_summary <- summarize(data,
          avg_rfstime = mean(rfstime, na.rm=T),
          .by = grade)

# reorder data table using arrange(): order by grade, within grade order by size
data_arranged <- arrange(data, grade, size)

# new visualization using updated dataset: 
data_only_stats = transmute(data,
                              size_by_grade = size/grade,
                              rfstime_by_size = rfstime/size)
new_data <- arrange(select(data,grade,rfstime), grade, rfstime)
ggplot(data=new_data, aes(x=grade, y=rfstime)) +
  geom_jitter(width=0.25) +
  labs(title='Recurrence Free Survival Time per Tumor Grade',
       x = 'Tumor Grade',
       y = 'Recurrence Free Survival Time (days)')
