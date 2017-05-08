/* 
================================================================================
檔案代號:xmaa_t
檔案名稱:信用評等公式資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmaa_t
(
xmaaent       number(5)      ,/* 企業編號 */
xmaa001       varchar2(10)      ,/* 信用評等編號 */
xmaa002       varchar2(10)      ,/* 計算項目 */
xmaa003       number(10,0)      ,/* 順序 */
xmaa004       varchar2(1)      ,/* 額度計算加減項 */
xmaa005       number(20,6)      ,/* 計算比率 */
xmaaownid       varchar2(20)      ,/* 資料所有者 */
xmaaowndp       varchar2(10)      ,/* 資料所屬部門 */
xmaacrtid       varchar2(20)      ,/* 資料建立者 */
xmaacrtdp       varchar2(10)      ,/* 資料建立部門 */
xmaacrtdt       timestamp(0)      ,/* 資料創建日 */
xmaamodid       varchar2(20)      ,/* 資料修改者 */
xmaamoddt       timestamp(0)      ,/* 最近修改日 */
xmaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmaa_t add constraint xmaa_pk primary key (xmaaent,xmaa001,xmaa002) enable validate;

create unique index xmaa_pk on xmaa_t (xmaaent,xmaa001,xmaa002);

grant select on xmaa_t to tiptop;
grant update on xmaa_t to tiptop;
grant delete on xmaa_t to tiptop;
grant insert on xmaa_t to tiptop;

exit;
