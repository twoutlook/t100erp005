/* 
================================================================================
檔案代號:pmdm_t
檔案名稱:採購多帳期預付款檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdm_t
(
pmdment       number(5)      ,/* 企業編號 */
pmdmsite       varchar2(10)      ,/* 營運據點 */
pmdmdocno       varchar2(20)      ,/* 採購單號 */
pmdm001       number(5,0)      ,/* 期別 */
pmdm002       varchar2(10)      ,/* 付款條件 */
pmdm003       date      ,/* 預計應付款日 */
pmdm004       date      ,/* 預計票據到期日 */
pmdm005       number(20,6)      ,/* 未稅金額 */
pmdm006       number(20,6)      ,/* 含稅金額 */
pmdm007       varchar2(20)      ,/* 應付帳款單號 */
pmdm008       number(20,6)      ,/* 主帳套立帳未稅金額 */
pmdm009       number(20,6)      ,/* 主帳套立帳含稅金額 */
pmdm010       number(20,6)      ,/* 帳套二立帳未稅金額 */
pmdm011       number(20,6)      ,/* 帳套二立帳含稅金額 */
pmdm012       number(20,6)      ,/* 帳套三立帳未稅金額 */
pmdm013       number(20,6)      ,/* 帳套三立帳含稅金額 */
pmdm014       varchar2(10)      ,/* 帳款類型 */
pmdm900       number(20,6)      ,/* 保留欄位str */
pmdm999       number(20,6)      ,/* 保留欄位end */
pmdmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmdm_t add constraint pmdm_pk primary key (pmdment,pmdmdocno,pmdm001) enable validate;

create unique index pmdm_pk on pmdm_t (pmdment,pmdmdocno,pmdm001);

grant select on pmdm_t to tiptop;
grant update on pmdm_t to tiptop;
grant delete on pmdm_t to tiptop;
grant insert on pmdm_t to tiptop;

exit;
