/* 
================================================================================
檔案代號:bcpa_t
檔案名稱:APP畫面動態產生設定單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bcpa_t
(
bcpaent       number(5)      ,/* 企業代碼 */
bcpasite       varchar2(10)      ,/* 營運據點 */
bcpa001       varchar2(20)      ,/* 作業代號 */
bcpastus       varchar2(10)      ,/* 狀態碼 */
bcpaownid       varchar2(20)      ,/* 資料所有者 */
bcpaowndp       varchar2(10)      ,/* 資料所屬部門 */
bcpacrtid       varchar2(20)      ,/* 資料建立者 */
bcpacrtdp       varchar2(10)      ,/* 資料建立部門 */
bcpacrtdt       timestamp(0)      ,/* 資料創建日 */
bcpamodid       varchar2(20)      ,/* 資料修改者 */
bcpamoddt       timestamp(0)      ,/* 最近修改日 */
bcpaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bcpaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bcpaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bcpaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bcpaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bcpaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bcpaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bcpaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bcpaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bcpaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bcpaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bcpaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bcpaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bcpaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bcpaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bcpaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bcpaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bcpaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bcpaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bcpaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bcpaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bcpaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bcpaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bcpaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bcpaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bcpaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bcpaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bcpaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bcpaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bcpaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bcpa_t add constraint bcpa_pk primary key (bcpaent,bcpasite,bcpa001) enable validate;

create unique index bcpa_pk on bcpa_t (bcpaent,bcpasite,bcpa001);

grant select on bcpa_t to tiptop;
grant update on bcpa_t to tiptop;
grant delete on bcpa_t to tiptop;
grant insert on bcpa_t to tiptop;

exit;
