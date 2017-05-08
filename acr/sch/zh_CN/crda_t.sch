/* 
================================================================================
檔案代號:crda_t
檔案名稱:會員RFM測量方式維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table crda_t
(
crdaent       number(5)      ,/* 企業編號 */
crdastus       varchar2(1)      ,/* 狀態 */
crda000       varchar2(1)      ,/* 等級 */
crda001       number(15,3)      ,/* R最小值 */
crda002       number(15,3)      ,/* R最大值 */
crda003       number(15,3)      ,/* F最小值 */
crda004       number(15,3)      ,/* F最大值 */
crda005       number(20,6)      ,/* M最小值 */
crda006       number(20,6)      ,/* M最大值 */
crda007       varchar2(1)      ,/* R計量單位 */
crda008       varchar2(1)      ,/* F計量單位 */
crda009       varchar2(1)      ,/* M計量單位 */
crda010       varchar2(500)      ,/* 備註 */
crdaownid       varchar2(20)      ,/* 資料所有者 */
crdaowndp       varchar2(10)      ,/* 資料所屬部門 */
crdacrtid       varchar2(20)      ,/* 資料建立者 */
crdacrtdp       varchar2(10)      ,/* 資料建立部門 */
crdacrtdt       timestamp(0)      ,/* 資料創建日 */
crdamodid       varchar2(20)      ,/* 資料修改者 */
crdamoddt       timestamp(0)      ,/* 最近修改日 */
crda011       number(5,2)      ,/* R值權重 */
crda012       number(5,2)      ,/* F值權重 */
crda013       number(5,2)      ,/* M值權重 */
crdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
crdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
crdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
crdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
crdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
crdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
crdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
crdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
crdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
crdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
crdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
crdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
crdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
crdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
crdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
crdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
crdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
crdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
crdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
crdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
crdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
crdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
crdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
crdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
crdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
crdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
crdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
crdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
crdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
crdaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table crda_t add constraint crda_pk primary key (crdaent,crda000) enable validate;

create unique index crda_pk on crda_t (crdaent,crda000);

grant select on crda_t to tiptop;
grant update on crda_t to tiptop;
grant delete on crda_t to tiptop;
grant insert on crda_t to tiptop;

exit;
