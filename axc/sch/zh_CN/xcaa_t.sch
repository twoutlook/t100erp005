/* 
================================================================================
檔案代號:xcaa_t
檔案名稱:標準成本分類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcaa_t
(
xcaaent       number(5)      ,/* 企業編號 */
xcaaownid       varchar2(20)      ,/* 資料所有者 */
xcaaowndp       varchar2(10)      ,/* 資料所屬部門 */
xcaacrtid       varchar2(20)      ,/* 資料建立者 */
xcaacrtdp       varchar2(10)      ,/* 資料建立部門 */
xcaacrtdt       timestamp(0)      ,/* 資料創建日 */
xcaamodid       varchar2(20)      ,/* 資料修改者 */
xcaamoddt       timestamp(0)      ,/* 最近修改日 */
xcaastus       varchar2(10)      ,/* 狀態碼 */
xcaa001       varchar2(10)      ,/* 標準成本分類 */
xcaa002       varchar2(1)      ,/* 是否主標準成本 */
xcaa003       varchar2(1)      ,/* 允許共享 */
xcaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcaa_t add constraint xcaa_pk primary key (xcaaent,xcaa001) enable validate;

create unique index xcaa_pk on xcaa_t (xcaaent,xcaa001);

grant select on xcaa_t to tiptop;
grant update on xcaa_t to tiptop;
grant delete on xcaa_t to tiptop;
grant insert on xcaa_t to tiptop;

exit;
