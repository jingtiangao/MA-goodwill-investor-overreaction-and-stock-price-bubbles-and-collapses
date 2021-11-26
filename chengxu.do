**********************************//����ʹ�õ������STATA13.0
**********************************//һ�����Ĳ��ֵĻع�������4ʹ���˶��������չ��ʲ����¼����ݣ��Ժ󵥶��㱨��
use shuju.dta,clear

//���ı�1�Ļع���
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
title("Table1 ��׼���") mtitle("NCSKEW" "NCSKEW" "NCSKEW" "DUVOL" "DUVOL" "DUVOL")
restore

//���ı�2�Ļع���
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
title("Table2 ������ɼ۱��̷��յķ����Թ�ϵ") mtitle("NCSKEW" "NCSKEW" "NCSKEW" "DUVOL" "DUVOL" "DUVOL")
restore

//���ı�3�ع���
preserve
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
keep if e(sample)==1  //ɾ����һ����ȱʧ������

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
title("Table3 �����Թɼ۱��ֵĴٽ��������Ÿ����Եķ�ת����") mtitle("ROA" "FROA" "CAR" "FCAR")
restore

//���ı�5�Ļع�����ע����4�Ľ����Ҫʹ�ò�ͬ�����ݣ��Ժ�㱨��Ӧ�����
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
title("Table5PanelA ��ROA�Ƿ��½���������") mtitle("ROA�½�" "ROA����" "ROA�½�" "ROA����")

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
title("Table5PanelB ����ROE�Ƿ��»�") mtitle("ROE�»�" "ROEδ�»�" "ROE�»�" "ROEδ�»�")

//���ı�6�Ļع���
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
title("Table6PanelA ���ֻ�����") mtitle("�߻���" "�ͻ���" "�߻���" "�ͻ���" )

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
title("Table6PanelB ���ֹ�ֵˮƽ") mtitle("�߹�ֵ" "�͹�ֵ" "�߹�ֵ" "�͹�ֵ" )

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
title("Table6PanelC ���������Ӿ�ɼ۱��̷���") mtitle("14-15" "07-13" "14-15" "07-13")

//���ı�7�Ļع���
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
title("Table7PanelA ���ֹ�˾���͸����") mtitle("DA��" "DA��" "DA��" "DA��" )

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
title("Table7PanelB ���ָܸ��ʸߵ�") mtitle("�߸ܸ�" "�͸ܸ�" "�߸ܸ�" "�͸ܸ�" )

//���ı�8�Ľ��
xi:reg F_NCSKEW SY_ratio Size Lev ROA tobinq1 W_mean W_sd NCSKEW d_turn abs_DA i.year i.ind,vce(cluster stkcd)
keep if e(sample)==1  //ɾ����һ����ȱʧ������
winsor2 jianchi_total,replace cuts(1 99)
gen High_SY=1 if Q4==1
replace High_SY=0 if High_SY==.
gen Low_SY=1 if Q1==1 | Q2==1 | Q3==1
replace L_SY=0 if Low_SY==. & High_SY==0
gen None_SY=1 if High_SY!=1 & Low_SY!=1
replace None_SY=0 if None_SY==.

sum jianchi_total if High_SY==1      //��������˾�߹ܼ��ֱ���
ttest jianchi_total==0 if High_SY==1

sum jianchi_total if Low_SY==1 //��������˾�߹ܼ��ֱ���
ttest jianchi_total==0 if Low_SY==1

sum jianchi_total if None_SY==1   //��������˾�߹ܼ��ֱ���
ttest jianchi_total==0 if None_SY==1

preserve  //������-������
keep if High_SY==1 | Low_SY==1
ttest jianchi_total,by(High_SY)
restore

preserve  //������-������
keep if High_SY==1 | None_SY==1
ttest jianchi_total,by(High_SY)
restore


*************************
*************************//������¼���ֵĻع���
//��¼ͼ1�Ļ���
use tuxing1.dta,clear
twoway bar SY year,yaxis(2)  barwidth(0.5) ///
     ylabel(0(500)4000,axis(2) angle(horizontal)) ytitle(��Ԫ,axis(2) placement(north)) || ///
     scatter bili year,m(T) lwidth(0.5) yaxis(1) c(l) ///
      mlabel(bili) mlabposition(12) mlabcolor(black) xlabel(2007(1)2015) ylabel(1(1)8,axis(1) angle(horizontal) format(%9.1f)) ytitle(%,axis(1) placement(north)) ///
      scheme(s1mono) 

//��¼��2�Ľ����������������ͳ��
use shuju.dta,clear
preserve
drop if F_NCSKEW==. | SY_ratio==. |  Size==. | Lev==. | ROA==. | tobinq1==. | W_mean==. | W_sd==. | NCSKEW==. | d_turn==. | abs_DA==.

logout, save(mytable) excel replace:       ///  
       tabstat  F_NCSKEW F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd d_turn abs_DA,   ///
	    stats(n mean sd min med max) c(s) f(%8.4f) 
		count if F_NCSKEW!=.
restore

//��¼��3�Ľ������ֵ����λ���������
///˵����ttable3�ǱȽϱ�����ֵ����λ��������ⲿ�����Ҫ�ֶ���װ��  ���⣬������Ĭ�ϱ���С�������λ���֣�������ttable3��ado file���޸�С����������λ��
gen SY_dummy=1 if SY_ratio>0
replace SY_dummy=0 if SY_dummy==.
preserve
drop if F_NCSKEW==. | SY_ratio==. |  Size==. | Lev==. | ROA==. | tobinq1==. | W_mean==. | W_sd==. | NCSKEW==. | d_turn==. | abs_DA==.
logout, save(mytable) excel replace:  ///
ttable3 F_NCSKEW F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd d_turn abs_DA,by(SY_dummy) f(%8.4f)          //��ֵ����Ƚ�
restore

preserve
drop if F_NCSKEW==. | SY_ratio==. |  Size==. | Lev==. | ROA==. | tobinq1==. | W_mean==. | W_sd==. | NCSKEW==. | d_turn==. | abs_DA==.
logout, save(mytable) excel replace:  ///  ������ttable3��ado file���޸�С����������λ��
ttable3 F_NCSKEW F_DUVOL SY_ratio Size Lev ROA tobinq1 W_mean W_sd d_turn abs_DA,by(SY_dummy)  median            //��λ������Ƚ�
restore

//��¼��9�Ļع���
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
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_p, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///  logitģ�ͣ���Ҫʹ��Pseudo-R��
title("Table9 ���������ͱ���ָ��") mtitle("F_CRASH"  "F_JUMP" )

//��¼��10�Ļع�������ͬ��ҵ������˾��������ֵ��Ϊ���߱���
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
title("Table10 ��ͬ��ҵ������˾��������ֵ��IV") mtitle("һ�׶�" "F_NESKEW" "F_DUVOL" "F_CRASH" )

//��11�Ļع������޳���Ȩת������
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
title("Table3 �޳���Ȩת������") mtitle("F_NCSKEW" "F_DUVOL" "F_CRASH"  )

//��12�Ļع���������������˾�������
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
drop(_Iyear* _Iind*) stats(Year_FE Ind_FE Cluster N r2_a, fmt(%3s %3s %3s %12.0f  %9.3f)) varwidth(20) ///  �������Pseudo-R2ʱ����Ҫ�ֶ�����һ��
title("Table12 ����������˾�������") mtitle("F_NCSKEW"  "F_DUVOL" "F_CRASH")

//��¼ͼ2
use tuxing2.dta,clear
scatter Q4 year,msymbol(O) connect(l)  ///
		mlabel(Q4) mlabposition(12) mlabcolor(black) ///
		ylabel(20 (50) 320,angle(horizontal)) ///
		xlabel(2006 (1) 2016) ///
		//xtitle(���,place(left)) ///
		title("ͼ3 �������չ�����ȷֲ�",position(6) ring(12)) ///
		legend(position(11)) ///
		scheme(s1mono)


***************************
***************************//���ı�4��ͳ�ƽ����ʹ�ö��������չ��¼���������ʱ���о������㲻ͬʱ�䴰�ڹɼ۵ĳ�������
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
