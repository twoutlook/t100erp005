/* 
================================================================================
檔案代號:bxba_t
檔案名稱:保稅產品結構單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxba_t
(
bxbaent       number(5)      ,/* 企業代碼 */
bxbasite       varchar2(10)      ,/* 營運據點 */
bxba001       varchar2(40)      ,/* 主件料號 */
bxba002       timestamp(0)      ,/* 生效日期 */
bxba003       timestamp(0)      ,/* 失效日期 */
bxba004       varchar2(40)      ,/* BOM編號 */
bxba005       varchar2(1)      ,/* 保稅BOM列印否 */
bxbastus       varchar2(10)      ,/* 狀態碼 */
bxbaownid       varchar2(20)      ,/* 資料所有者 */
bxbaowndp       varchar2(10)      ,/* 資料所屬部門 */
bxbacrtid       varchar2(20)      ,/* 資料建立者 */
bxbacrtdp       varchar2(10)      ,/* 資料建立部門 */
bxbacrtdt       timestamp(0)      ,/* 資料創建日 */
bxbamodid       varchar2(20)      ,/* 資料修改者 */
bxbamoddt       timestamp(0)      ,/* 最近修改日 */
bxbacnfid       varchar2(20)      ,/* 資料確認者 */
bxbacnfdt       timestamp(0)      ,/* 資料確認日 */
bxbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxba_t add constraint bxba_pk primary key (bxbaent,bxbasite,bxba001,bxba002) enable validate;

create unique index bxba_pk on bxba_t (bxbaent,bxbasite,bxba001,bxba002);

grant select on bxba_t to tiptop;
grant update on bxba_t to tiptop;
grant delete on bxba_t to tiptop;
grant insert on bxba_t to tiptop;

exit;
