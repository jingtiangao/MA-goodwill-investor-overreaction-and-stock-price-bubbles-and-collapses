**********************************//本文使用的软件是STATA13.0
**********************************//一、正文部分的回归结果（表4使用了定向增发收购资产的事件数据，稍后单独汇报）
use shuju.dta,clear

//正文表1的回归结果
preserve
drop if F_NCSKEW==. | SY_ratio==. |  Size==. | Lev==. | ROA==. | tobinq1==. | W_mean==. | W_sd==. | NCSKEW==. | d_turn==. | abs_DA==.
xi:reg F_NCSKEW SY_ratio  i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace 
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m1
xi:reg F_NCSKEW SY_ratio  Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m2
xi:reg F_NCSKEW SY_ratio  Size Lev ROA  tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m3
xi:reg F_DUVOL SY_ratio i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m4
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m5
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m6
logout, save(mylogout) word replace fix(4):            ///
esttab m1 m2 m3 m4 m5 m6, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap  ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20)  ///
title("Table1 基准结果") mtitle("NCSKEW" "NCSKEW" "NCSKEW" "DUVOL" "DUVOL" "DUVOL")
restore

//正文表2的回归结果
preserve
drop if F_NCSKEW==. | SY_ratio==. |  Size==. | Lev==. | ROA==. | tobinq1==. | W_mean==. | W_sd==. | NCSKEW==. | d_turn==. | abs_DA==.
xi:reg F_NCSKEW Q1_SY Q2_SY Q3_SY Q4_SY  i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace 
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m1
xi:reg F_NCSKEW Q1_SY Q2_SY Q3_SY Q4_SY  Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m2
xi:reg F_NCSKEW Q1_SY Q2_SY Q3_SY Q4_SY Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m3
xi:reg F_DUVOL Q1_SY Q2_SY Q3_SY Q4_SY i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m4
xi:reg F_DUVOL Q1_SY Q2_SY Q3_SY Q4_SY Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m5
xi:reg F_DUVOL Q1_SY Q2_SY Q3_SY Q4_SY Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m6

logout, save(mylogout) word replace fix(4):            ///
esttab m1 m2 m3 m4 m5 m6, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap  ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20)  ///
title("Table2 商誉与股价崩盘风险的非线性关系") mtitle("NCSKEW" "NCSKEW" "NCSKEW" "DUVOL" "DUVOL" "DUVOL")
restore

//正文表3回归结果
preserve
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
keep if e(sample)==1  //删除任一变量缺失的样本

xi:reg ROA SY_ratio Size Lev re_growth CPTEP VOL lnPay Dual dudong_num dd_bili i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m30

xi:reg FROA  SY_ratio Size Lev re_growth CPTEP VOL lnPay Dual dudong_num dd_bili i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m31


xi:reg CAR SY_ratio Size Lev re_growth CPTEP VOL lnPay Dual dudong_num dd_bili i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m32

xi:reg F1CAR  SY_ratio Size Lev re_growth CPTEP VOL lnPay Dual dudong_num dd_bili i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m33


logout, save(mylogout) word replace fix(5):            ///
esttab m30 m31 m32 m33, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///
title("Table3 商誉对股价表现的促进作用有着更明显的反转特征") mtitle("ROA" "FROA" "CAR" "FCAR")
restore

//正文表5的回归结果。注：表4的结果需要使用不同的数据，稍后汇报相应结果。
preserve
gen UP_ROA=1 if FROA>ROA
replace UP_ROA=0 if UP_ROA==.
keep if UP_ROA==0
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m37
restore

preserve
gen UP_ROA=1 if FROA>ROA
replace UP_ROA=0 if UP_ROA==.
keep if UP_ROA==1
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m38
restore

preserve
gen UP_ROA=1 if FROA>ROA
replace UP_ROA=0 if UP_ROA==.
keep if UP_ROA==0
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m39
restore 

preserve 
gen UP_ROA=1 if FROA>ROA
replace UP_ROA=0 if UP_ROA==.
keep if UP_ROA==1
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m40
restore

logout, save(mylogout) word replace fix(5):            ///
esttab m37 m38 m39 m40, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///
title("Table5PanelA 用ROA是否下降区分样本") mtitle("ROA下降" "ROA上升" "ROA下降" "ROA上升")

preserve
keep if UP_ROE==0
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m15
restore

preserve
keep if UP_ROE==1
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m16
restore

preserve
keep if  UP_ROE==0
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m17
restore 

preserve 
keep if UP_ROE==1
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m18
restore

logout, save(mylogout) word replace fix(5):            ///
esttab m15 m16 m17 m18, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///
title("Table5PanelB 区分ROE是否下滑") mtitle("ROE下滑" "ROE未下滑" "ROE下滑" "ROE未下滑")

//正文表6的回归结果
preserve
keep if H_turn==1
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m27
restore

preserve
keep if H_turn==0
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m28
restore

preserve
keep if  H_turn==1
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m29
restore 

preserve 
keep if H_turn==0
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m30
restore

logout, save(mylogout) word replace fix(5):            ///
esttab m27 m28 m29 m30, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///
title("Table6PanelA 区分换手率") mtitle("高换手" "低换手" "高换手" "低换手" )

preserve
keep if H_guzhi==1
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m7
restore

preserve
keep if H_guzhi==0
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m8
restore

preserve
keep if  H_guzhi==1
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m9
restore 

preserve 
keep if H_guzhi==0
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m10
restore

logout, save(mylogout) word replace fix(5):            ///
esttab m7 m8 m9 m10, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///
title("Table6PanelB 区分估值水平") mtitle("高估值" "低估值" "高估值" "低估值" )

preserve
keep if  year==2014 | year==2015
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m33
restore

preserve
keep if year<=2013
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m34
restore

preserve
keep if  year==2014 | year==2015
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m35
restore 

preserve 
keep if year<=2013
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m36
restore

logout, save(mylogout) word replace fix(5):            ///
esttab m33 m34 m35 m36, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///
title("Table6PanelC 后期商誉加剧股价崩盘风险") mtitle("14-15" "07-13" "14-15" "07-13")

//正文表7的回归结果
preserve
keep if H_DA==1
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m11
restore

preserve
keep if H_DA==0
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m12
restore

preserve
keep if  H_DA==1
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m13
restore 

preserve 
keep if H_DA==0
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m14
restore


logout, save(mylogout) word replace fix(5):            ///
esttab m11 m12 m13 m14, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///
title("Table7PanelA 区分公司会计透明度") mtitle("DA高" "DA低" "DA高" "DA低" )

preserve
keep if H_Lev1==1
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m27
restore

preserve
keep if H_Lev1==0
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m28
restore

preserve
keep if  H_Lev1==1
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m29
restore 

preserve 
keep if H_Lev1==0
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m30
restore

logout, save(mylogout) word replace fix(5):            ///
esttab m27 m28 m29 m30, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///
title("Table7PanelB 区分杠杆率高低") mtitle("高杠杆" "低杠杆" "高杠杆" "低杠杆" )

//正文表8的结果
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
keep if e(sample)==1  //删除任一变量缺失的样本
winsor2 jianchi_total,replace cuts(1 99)
gen High_SY=1 if Q4==1
replace High_SY=0 if High_SY==.
gen Low_SY=1 if Q1==1 | Q2==1 | Q3==1
replace L_SY=0 if Low_SY==. & High_SY==0
gen None_SY=1 if High_SY!=1 & Low_SY!=1
replace None_SY=0 if None_SY==.

sum jianchi_total if High_SY==1      //高商誉公司高管减持比例
ttest jianchi_total==0 if High_SY==1

sum jianchi_total if Low_SY==1 //低商誉公司高管减持比例
ttest jianchi_total==0 if Low_SY==1

sum jianchi_total if None_SY==1   //无商誉公司高管减持比例
ttest jianchi_total==0 if None_SY==1

preserve  //高商誉-低商誉
keep if High_SY==1 | Low_SY==1
ttest jianchi_total,by(High_SY)
restore

preserve  //高商誉-无商誉
keep if High_SY==1 | None_SY==1
ttest jianchi_total,by(High_SY)
restore


*************************
*************************//二、附录部分的回归结果
//附录图1的绘制
use tuxing1.dta,clear
twoway bar SY year,yaxis(2)  barwidth(0.5) ///
     ylabel(0(500)4000,axis(2) angle(horizontal)) ytitle(亿元,axis(2) placement(north)) || ///
     scatter bili year,m(T) lwidth(0.5) yaxis(1) c(l) ///
      mlabel(bili) mlabposition(12) mlabcolor(black) xlabel(2007(1)2015) ylabel(1(1)8,axis(1) angle(horizontal) format(%9.1f)) ytitle(%,axis(1) placement(north)) ///
      scheme(s1mono) 

//附录表2的结果，变量的描述性统计
use shuju.dta,clear
preserve
drop if F_NCSKEW==. | SY_ratio==. |  Size==. | Lev==. | ROA==. | tobinq1==. | W_mean==. | W_sd==. | NCSKEW==. | d_turn==. | abs_DA==.

logout, save(mytable) excel replace:       ///  
       tabstat  F_NCSKEW F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd d_turn abs_DA,   ///
	    stats(n mean sd min med max) c(s) f(%8.4f) 
		count if F_NCSKEW!=.
restore

//附录表3的结果，均值和中位数差异检验
///说明：ttable3是比较变量均值和中位数差异的外部命令，需要手动安装。  此外，该命令默认保留小数点后三位数字，可以在ttable3的ado file中修改小数点后的数字位数
gen SY_dummy=1 if SY_ratio>0
replace SY_dummy=0 if SY_dummy==.
preserve
drop if F_NCSKEW==. | SY_ratio==. |  Size==. | Lev==. | ROA==. | tobinq1==. | W_mean==. | W_sd==. | NCSKEW==. | d_turn==. | abs_DA==.
logout, save(mytable) excel replace:  ///
ttable3 F_NCSKEW F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd d_turn abs_DA,by(SY_dummy) f(%8.4f)          //均值差异比较
restore

preserve
drop if F_NCSKEW==. | SY_ratio==. |  Size==. | Lev==. | ROA==. | tobinq1==. | W_mean==. | W_sd==. | NCSKEW==. | d_turn==. | abs_DA==.
logout, save(mytable) excel replace:  ///  可以在ttable3的ado file中修改小数点后的数字位数
ttable3 F_NCSKEW F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd d_turn abs_DA,by(SY_dummy)  median            //中位数差异比较
restore

//附录表9的回归结果
xi:logit F_CRASH SY_ratio  Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m29

xi:logit F_BAOZHANG SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m30

logout, save(mylogout) word replace fix(5):            ///
esttab m29 m30, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_p, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///  logit模型，需要使用Pseudo-R方
title("Table9 更换被解释变量指标") mtitle("F_CRASH"  "F_JUMP" )

//附录表10的回归结果，以同行业其他公司的商誉均值作为工具变量
preserve
xi:reg SY_ratio ind_SY Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m40
restore 

preserve
xi:ivregress 2sls F_NCSKEW (SY_ratio=ind_SY) Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m41
restore 

preserve
xi:ivregress 2sls F_DUVOL (SY_ratio=ind_SY) Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m42
restore 

preserve
xi:ivregress 2sls F_CRASH (SY_ratio=ind_SY) Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m43
restore 

logout, save(mylogout) word replace fix(5):            ///
esttab m40 m41 m42 m43, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_p, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///
title("Table10 用同行业其他公司的商誉均值做IV") mtitle("一阶段" "F_NESKEW" "F_DUVOL" "F_CRASH" )

//表11的回归结果，剔除股权转让样本
preserve
keep if zhuanrang!=1
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m27
restore

preserve
keep if zhuanrang!=1
xi:reg F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m28
restore

preserve
keep if zhuanrang!=1
xi:logit F_CRASH SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m29
restore

logout, save(mylogout) word replace fix(5):            ///
esttab m27 m28 m29 , star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///
title("Table3 剔除股权转让样本") mtitle("F_NCSKEW" "F_DUVOL" "F_CRASH"  )

//表12的回归结果，加入其他公司治理变量
preserve
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA d_num dd_bili Dual i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m47
restore 

preserve
xi:reg F_DUVOL  SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA d_num dd_bili Dual i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m48
restore 

preserve
xi:logit F_CRASH SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA d_num dd_bili Dual i.year i.ind,vce(cluster stkcd)
estadd local Cluster "Yes",replace
estadd local Year_FE "Yes",replace
estadd local Ind_FE "Yes",replace
est store m49
restore 

logout, save(mylogout) word replace fix(5):            ///
esttab m47 m48 m49, star(* 0.1 ** 0.05 *** 0.01) b(%6.4f) t(%6.4f) compress nogap ///
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///  这里输出Pseudo-R2时还需要手动操作一次
title("Table12 加入其他公司治理变量") mtitle("F_NCSKEW"  "F_DUVOL" "F_CRASH")

//附录图2
use tuxing2.dta,clear
scatter Q4 year,msymbol(O) connect(l)  ///
		mlabel(Q4) mlabposition(12) mlabcolor(black) ///
		ylabel(20 (50) 320,angle(horizontal)) ///
		xlabel(2006 (1) 2016) ///
		//xtitle(年份,place(left)) ///
		title("图3 高商誉收购的年度分布",position(6) ring(12)) ///
		legend(position(11)) ///
		scheme(s1mono)


***************************
***************************//正文表4的统计结果，使用定向增发收购事件，并利用时间研究法计算不同时间窗口股价的超额收益
use MA.dta,clear
sum car11 if year<=2013
sum car22 if year<=2013
sum BHAR240 if year<=2013

sum car11 if year==2014
sum car22 if year==2014
sum BHAR240 if year==2014

sum car11 if year==2015 & month<=6
sum car22 if year==2015 & month<=6
sum BHAR240 if year==2015 & month<=6

sum car11 if year==2015 & month>=7 
sum car22 if year==2015 & month>=7 
sum BHAR240 if year==2015 & month>=7 
