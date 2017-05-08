/* 
================================================================================
檔案代號:stcs_t
檔案名稱:分銷客戶陳列協議資源明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcs_t
(
stcsent       number(5)      ,/* 企業編號 */
stcsunit       varchar2(10)      ,/* 應用組織 */
stcssite       varchar2(10)      ,/* 營運據點 */
stcsdocno       varchar2(20)      ,/* 單據編號 */
stcsseq       number(10,0)      ,/* 項次 */
stcs001       varchar2(10)      ,/* 資源類型 */
stcs002       number(5,0)      ,/* 陳列資源數量 */
stcs003       number(5,0)      ,/* 陳列資源層數 */
stcs004       number(20,6)      ,/* 陳列資源長度 */
stcs005       varchar2(40)      ,/* 產品編號 */
stcs006       varchar2(80)      ,/* 位置說明 */
stcs007       varchar2(80)      ,/* 備註 */
stcsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcs_t add constraint stcs_pk primary key (stcsent,stcsdocno,stcsseq) enable validate;

create unique index stcs_pk on stcs_t (stcsent,stcsdocno,stcsseq);

grant select on stcs_t to tiptop;
grant update on stcs_t to tiptop;
grant delete on stcs_t to tiptop;
grant insert on stcs_t to tiptop;

exit;
