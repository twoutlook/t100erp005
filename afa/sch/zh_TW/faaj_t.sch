/* 
================================================================================
檔案代號:faaj_t
檔案名稱:固定資產帳套折舊資訊資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faaj_t
(
faajent       number(5)      ,/* 企業編碼 */
faajld       varchar2(5)      ,/* 帳套別編碼 */
faajsite       varchar2(10)      ,/* 營運據點 */
faaj000       varchar2(20)      ,/* 批號 */
faaj001       varchar2(20)      ,/* 財產編號 */
faaj002       varchar2(20)      ,/* 附號 */
faaj003       number(10)      ,/* 折舊方式 */
faaj004       number(10,0)      ,/* 耐用年限(月數) */
faaj005       number(10,0)      ,/* 未使用年限(月數) */
faaj006       number(10)      ,/* 分攤方式 */
faaj007       varchar2(80)      ,/* 分攤類別 */
faaj008       varchar2(10)      ,/* 開始折舊年月 */
faaj009       number(5,0)      ,/* 最近折舊年度 */
faaj010       number(5,0)      ,/* 最近折舊期別 */
faaj011       varchar2(1)      ,/* 折畢再提 */
faaj012       number(15,3)      ,/* 折畢再提預留殘值 */
faaj013       number(10,0)      ,/* 折畢再提預留年月（數） */
faaj014       varchar2(10)      ,/* 幣別 */
faaj015       number(20,10)      ,/* 匯率 */
faaj016       number(20,6)      ,/* 成本 */
faaj017       number(20,6)      ,/* 累折 */
faaj018       number(20,6)      ,/* 本期累折 */
faaj019       number(20,6)      ,/* 預留殘值 */
faaj020       number(20,6)      ,/* 調整成本 */
faaj021       number(20,6)      ,/* 已提列減值準備 */
faaj022       number(20,6)      ,/* 年折舊額 */
faaj023       varchar2(24)      ,/* 資產科目 */
faaj024       varchar2(24)      ,/* 累折科目 */
faaj025       varchar2(24)      ,/* 折舊科目 */
faaj026       varchar2(24)      ,/* 減值準備科目 */
faaj027       number(20,6)      ,/* 銷帳減值準備 */
faaj028       number(20,6)      ,/* 未折減額 */
faaj029       number(20,6)      ,/* 第一個月未折減額 */
faaj030       varchar2(20)      ,/* 帳款編號 */
faaj031       varchar2(20)      ,/* 帳款編號項次 */
faaj032       number(20,6)      ,/* 本期處置累折 */
faaj033       number(20,6)      ,/* 處置數量 */
faaj034       number(20,6)      ,/* 處置成本 */
faaj035       number(20,6)      ,/* 處置累折 */
faaj036       varchar2(10)      ,/* 交易價格差異 */
faaj037       varchar2(10)      ,/* 卡片編號 */
faaj038       number(10)      ,/* 資產狀態 */
faaj039       varchar2(10)      ,/* 部門 */
faaj040       varchar2(10)      ,/* 利潤/成本中心 */
faaj041       varchar2(10)      ,/* 區域 */
faaj042       varchar2(10)      ,/* 交易客商 */
faaj043       varchar2(10)      ,/* 帳款客商 */
faaj044       varchar2(10)      ,/* 客群 */
faaj045       varchar2(20)      ,/* 專案編號 */
faaj046       varchar2(30)      ,/* WBS */
faaj047       varchar2(20)      ,/* 人員 */
faaj101       varchar2(10)      ,/* 本位幣二幣別 */
faaj102       number(20,10)      ,/* 本位幣二匯率 */
faaj103       number(20,6)      ,/* 本位幣二成本 */
faaj104       number(20,6)      ,/* 本位幣二累折 */
faaj105       number(20,6)      ,/* 本位幣二預留殘值 */
faaj106       number(20,6)      ,/* 本位幣二折畢再提預留殘值 */
faaj107       number(20,6)      ,/* 本位幣二年折舊額 */
faaj108       number(20,6)      ,/* 本位幣二未折減額 */
faaj109       number(20,6)      ,/* 本位幣二第一月未折減額 */
faaj110       number(20,6)      ,/* 本位幣二處置減值準備 */
faaj111       number(20,6)      ,/* 本位幣二本年累折 */
faaj112       number(20,6)      ,/* 本位幣二已提列減值準備 */
faaj113       number(20,6)      ,/* 本位幣二處置成本 */
faaj114       number(20,6)      ,/* 本位幣二處置累折 */
faaj115       number(20,6)      ,/* 本位幣二本期處置累折 */
faaj116       number(20,6)      ,/* 本位幣二交易價格差異 */
faaj117       number(20,6)      ,/* 本位幣二調整成本 */
faaj151       varchar2(10)      ,/* 本位幣三幣別 */
faaj152       number(20,10)      ,/* 本位幣三匯率 */
faaj153       number(20,6)      ,/* 本位幣三成本 */
faaj154       number(20,6)      ,/* 本位幣三累折 */
faaj155       number(20,6)      ,/* 本位幣三預留殘值 */
faaj156       number(20,6)      ,/* 本位幣三折畢再提預留殘值 */
faaj157       number(20,6)      ,/* 本位幣三年折舊額 */
faaj158       number(20,6)      ,/* 本位幣三未折減額 */
faaj159       number(20,6)      ,/* 本位幣三第一月未折減額 */
faaj160       number(20,6)      ,/* 本位幣三處置減值準備 */
faaj161       number(20,6)      ,/* 本位幣三本年累折 */
faaj162       number(20,6)      ,/* 本位幣三已提列減值準備 */
faaj163       number(20,6)      ,/* 本位幣三處置成本 */
faaj164       number(20,6)      ,/* 本位幣三處置累折 */
faaj165       number(20,6)      ,/* 本位幣三本期處置累折 */
faaj166       number(20,6)      ,/* 本位幣三交易價格差異 */
faaj167       number(20,6)      ,/* 本位幣三調整成本 */
faajownid       varchar2(20)      ,/* 資料所有者 */
faajowndp       varchar2(10)      ,/* 資料所屬部門 */
faajcrtid       varchar2(20)      ,/* 資料建立者 */
faajcrtdp       varchar2(10)      ,/* 資料建立部門 */
faajcrtdt       timestamp(0)      ,/* 資料創建日 */
faajmodid       varchar2(20)      ,/* 資料修改者 */
faajmoddt       timestamp(0)      ,/* 最近修改日 */
faajstus       varchar2(10)      ,/* 狀態碼 */
faaj048       varchar2(100)      /* 列帳/列管 */
);
alter table faaj_t add constraint faaj_pk primary key (faajent,faajld,faaj000,faaj001,faaj002,faaj037) enable validate;

create unique index faaj_pk on faaj_t (faajent,faajld,faaj000,faaj001,faaj002,faaj037);

grant select on faaj_t to tiptop;
grant update on faaj_t to tiptop;
grant delete on faaj_t to tiptop;
grant insert on faaj_t to tiptop;

exit;
