/* 
================================================================================
檔案代號:pmdv_t
檔案名稱:收貨/入庫需求分配明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdv_t
(
pmdvent       number(5)      ,/* 企業編號 */
pmdvsite       varchar2(10)      ,/* 營運據點 */
pmdvdocno       varchar2(20)      ,/* 單據編號 */
pmdvseq       number(10,0)      ,/* 項次 */
pmdvseq1       number(10,0)      ,/* 項序 */
pmdv001       varchar2(40)      ,/* 收貨料件編號 */
pmdv002       varchar2(256)      ,/* 收貨產品特徵 */
pmdv003       varchar2(10)      ,/* 作業編號 */
pmdv004       varchar2(10)      ,/* 作業序 */
pmdv005       varchar2(10)      ,/* 子件特性 */
pmdv006       number(20,6)      ,/* QPA */
pmdv011       varchar2(20)      ,/* 採購單號 */
pmdv012       number(10,0)      ,/* 採購項次 */
pmdv013       number(10,0)      ,/* 採購項序 */
pmdv014       varchar2(20)      ,/* 需求單號 */
pmdv015       number(10,0)      ,/* 需求項次 */
pmdv016       number(10,0)      ,/* 需求項序 */
pmdv017       number(10,0)      ,/* 需求分批序 */
pmdv018       varchar2(10)      ,/* 收貨/入庫單位 */
pmdv019       number(20,6)      ,/* 收貨/入庫分配數量 */
pmdv900       number(20,6)      ,/* 保留欄位str */
pmdv999       number(20,6)      ,/* 保留欄位end */
pmdvud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdvud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdvud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdvud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdvud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdvud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdvud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdvud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdvud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdvud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdvud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdvud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdvud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdvud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdvud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdvud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdvud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdvud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdvud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdvud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdvud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdvud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdvud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdvud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdvud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdvud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdvud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdvud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdvud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdvud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmdv200       varchar2(10)      ,/* 包裝單位 */
pmdv201       number(20,6)      /* 包裝數量 */
);
alter table pmdv_t add constraint pmdv_pk primary key (pmdvent,pmdvdocno,pmdvseq,pmdvseq1) enable validate;

create unique index pmdv_pk on pmdv_t (pmdvent,pmdvdocno,pmdvseq,pmdvseq1);

grant select on pmdv_t to tiptop;
grant update on pmdv_t to tiptop;
grant delete on pmdv_t to tiptop;
grant insert on pmdv_t to tiptop;

exit;
