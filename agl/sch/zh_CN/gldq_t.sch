/* 
================================================================================
檔案代號:gldq_t
檔案名稱:調整與銷除傳票單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table gldq_t
(
gldqent       number(5)      ,/* 企業代碼 */
gldqdocno       varchar2(20)      ,/* 傳票編號 */
gldqseq       number(10,0)      ,/* 項次 */
gldq001       varchar2(24)      ,/* 科目編號 */
gldq003       varchar2(10)      ,/* 營運據點 */
gldq004       varchar2(10)      ,/* 部門 */
gldq005       varchar2(10)      ,/* 利潤/成本中心 */
gldq006       varchar2(10)      ,/* 區域 */
gldq007       varchar2(10)      ,/* 交易客商 */
gldq008       varchar2(10)      ,/* 帳款客商 */
gldq009       varchar2(10)      ,/* 客群 */
gldq010       varchar2(10)      ,/* 產品類別 */
gldq011       varchar2(10)      ,/* 經營方式 */
gldq012       varchar2(10)      ,/* 渠道 */
gldq013       varchar2(10)      ,/* 品牌 */
gldq014       varchar2(20)      ,/* 人員 */
gldq015       varchar2(20)      ,/* 專案編號 */
gldq016       varchar2(30)      ,/* WBS */
gldq017       number(20,6)      ,/* 借方金額(記帳幣) */
gldq018       number(20,6)      ,/* 貸方金額(記帳幣) */
gldq019       number(20,6)      ,/* 借方金額(功能幣) */
gldq020       number(20,6)      ,/* 貸方金額(功能幣) */
gldq021       number(20,6)      ,/* 借方金額(報告幣) */
gldq022       number(20,6)      ,/* 貸方金額(報告幣) */
gldq023       varchar2(255)      ,/* 摘要 */
gldqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldq_t add constraint gldq_pk primary key (gldqent,gldqdocno,gldqseq) enable validate;

create unique index gldq_pk on gldq_t (gldqent,gldqdocno,gldqseq);

grant select on gldq_t to tiptop;
grant update on gldq_t to tiptop;
grant delete on gldq_t to tiptop;
grant insert on gldq_t to tiptop;

exit;
