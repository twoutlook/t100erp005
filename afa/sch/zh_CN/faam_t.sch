/* 
================================================================================
檔案代號:faam_t
檔案名稱:固定資產折舊明細資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table faam_t
(
faament       number(5)      ,/* 企業編號 */
faamsite       varchar2(10)      ,/* 資產中心 */
faamld       varchar2(5)      ,/* 帳別編碼 */
faamcomp       varchar2(10)      ,/* 法人 */
faam000       varchar2(10)      ,/* 卡片編號 */
faam001       varchar2(20)      ,/* 財產編號 */
faam002       varchar2(20)      ,/* 附號 */
faam003       number(10)      ,/* 折舊方式 */
faam004       number(5,0)      ,/* 折舊年度 */
faam005       number(5,0)      ,/* 折舊期別 */
faam006       number(10)      ,/* 來源 */
faam007       number(10)      ,/* 分攤方式 */
faam008       varchar2(10)      ,/* 分攤類別 */
faam009       varchar2(10)      ,/* 部門 */
faam010       varchar2(10)      ,/* 被分攤部門 */
faam011       varchar2(10)      ,/* 幣別 */
faam012       number(20,10)      ,/* 匯率 */
faam013       number(20,6)      ,/* 折舊金額 */
faam014       number(20,6)      ,/* 成本 */
faam015       number(20,6)      ,/* 累折 */
faam016       number(20,6)      ,/* 本年累折 */
faam017       number(20,6)      ,/* 分攤比率 */
faam018       number(20,6)      ,/* 已提列減值準備 */
faam019       number(20,6)      ,/* 年折舊額 */
faam020       varchar2(24)      ,/* 資產科目 */
faam021       varchar2(24)      ,/* 累折科目 */
faam022       varchar2(24)      ,/* 折舊科目 */
faam023       varchar2(24)      ,/* 減值準備科目 */
faam024       varchar2(20)      ,/* 傳票單號 */
faam025       number(10,0)      ,/* 傳票單號項次 */
faam026       varchar2(10)      ,/* 資產狀態 */
faam027       varchar2(10)      ,/* 營運據點 */
faam028       varchar2(10)      ,/* 部門 */
faam029       varchar2(10)      ,/* 利潤/成本中心 */
faam030       varchar2(10)      ,/* 區域 */
faam031       varchar2(10)      ,/* 交易客商 */
faam032       varchar2(10)      ,/* 帳款客商 */
faam033       varchar2(10)      ,/* 客群 */
faam034       varchar2(20)      ,/* 人員 */
faam035       varchar2(20)      ,/* 專案編號 */
faam036       varchar2(30)      ,/* WBS */
faam037       varchar2(10)      ,/* 經營方式 */
faam038       varchar2(10)      ,/* 渠道 */
faam039       varchar2(10)      ,/* 品牌 */
faam040       varchar2(10)      ,/* 自由核算項一 */
faam041       varchar2(10)      ,/* 自由核算項二 */
faam042       varchar2(10)      ,/* 自由核算項三 */
faam043       varchar2(10)      ,/* 自由核算項四 */
faam044       varchar2(10)      ,/* 自由核算項五 */
faam045       varchar2(10)      ,/* 自由核算項六 */
faam046       varchar2(10)      ,/* 自由核算項七 */
faam047       varchar2(10)      ,/* 自由核算項八 */
faam048       varchar2(10)      ,/* 自由核算項九 */
faam049       varchar2(10)      ,/* 自由核算項十 */
faam050       varchar2(40)      ,/* 摘要 */
faam101       varchar2(10)      ,/* 本位幣二幣別 */
faam102       number(20,10)      ,/* 本位幣二匯率 */
faam103       number(20,6)      ,/* 本位幣二成本 */
faam104       number(20,6)      ,/* 本位幣二折舊金額 */
faam105       number(20,6)      ,/* 本位幣二累折 */
faam106       number(20,6)      ,/* 本位幣二本年累折 */
faam107       number(20,6)      ,/* 本位幣二年折舊額 */
faam108       number(20,6)      ,/* 本位幣二已提列減值準備 */
faam151       varchar2(10)      ,/* 本位幣三幣別 */
faam152       number(20,10)      ,/* 本位幣三匯率 */
faam153       number(20,6)      ,/* 本位幣三成本 */
faam154       number(20,6)      ,/* 本位幣三折舊金額 */
faam155       number(20,6)      ,/* 本位幣三累折 */
faam156       number(20,6)      ,/* 本位幣三本年累折 */
faam157       number(20,6)      ,/* 本位幣三年折舊額 */
faam158       number(20,6)      ,/* 本位幣三已提列減值準備 */
faamud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
faamud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
faamud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
faamud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
faamud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
faamud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
faamud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
faamud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
faamud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
faamud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
faamud011       number(20,6)      ,/* 自定義欄位(數字)011 */
faamud012       number(20,6)      ,/* 自定義欄位(數字)012 */
faamud013       number(20,6)      ,/* 自定義欄位(數字)013 */
faamud014       number(20,6)      ,/* 自定義欄位(數字)014 */
faamud015       number(20,6)      ,/* 自定義欄位(數字)015 */
faamud016       number(20,6)      ,/* 自定義欄位(數字)016 */
faamud017       number(20,6)      ,/* 自定義欄位(數字)017 */
faamud018       number(20,6)      ,/* 自定義欄位(數字)018 */
faamud019       number(20,6)      ,/* 自定義欄位(數字)019 */
faamud020       number(20,6)      ,/* 自定義欄位(數字)020 */
faamud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
faamud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
faamud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
faamud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
faamud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
faamud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
faamud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
faamud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
faamud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
faamud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table faam_t add constraint faam_pk primary key (faament,faamld,faam000,faam001,faam002,faam004,faam005,faam006,faam007,faam009) enable validate;

create unique index faam_pk on faam_t (faament,faamld,faam000,faam001,faam002,faam004,faam005,faam006,faam007,faam009);

grant select on faam_t to tiptop;
grant update on faam_t to tiptop;
grant delete on faam_t to tiptop;
grant insert on faam_t to tiptop;

exit;
