/* 
================================================================================
檔案代號:xcaw_t
檔案名稱:成本次要素與資源關係設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcaw_t
(
xcawent       number(5)      ,/* 企業編號 */
xcawownid       varchar2(20)      ,/* 資料所有者 */
xcawowndp       varchar2(10)      ,/* 資料所屬部門 */
xcawcrtid       varchar2(20)      ,/* 資料建立者 */
xcawcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcawcrtdt       timestamp(0)      ,/* 資料創建日 */
xcawmodid       varchar2(20)      ,/* 資料修改者 */
xcawmoddt       timestamp(0)      ,/* 最近修改日 */
xcawstus       varchar2(10)      ,/* 狀態碼 */
xcaw001       varchar2(10)      ,/* 資源編號 */
xcaw002       varchar2(10)      ,/* 成本次要素 */
xcawud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcawud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcawud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcawud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcawud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcawud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcawud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcawud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcawud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcawud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcawud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcawud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcawud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcawud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcawud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcawud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcawud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcawud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcawud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcawud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcawud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcawud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcawud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcawud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcawud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcawud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcawud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcawud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcawud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcawud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcaw_t add constraint xcaw_pk primary key (xcawent,xcaw001) enable validate;

create unique index xcaw_pk on xcaw_t (xcawent,xcaw001);

grant select on xcaw_t to tiptop;
grant update on xcaw_t to tiptop;
grant delete on xcaw_t to tiptop;
grant insert on xcaw_t to tiptop;

exit;
