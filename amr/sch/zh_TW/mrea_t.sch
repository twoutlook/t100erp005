/* 
================================================================================
檔案代號:mrea_t
檔案名稱:資源設備盤點單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mrea_t
(
mreaent       number(5)      ,/* 企業編號 */
mreasite       varchar2(10)      ,/* 營運據點 */
mreadocno       varchar2(20)      ,/* 單據單號 */
mreadocdt       date      ,/* 單據日期 */
mrea001       varchar2(20)      ,/* 盤點人員 */
mrea002       varchar2(10)      ,/* 盤點部門 */
mrea003       date      ,/* 過帳日期 */
mreaownid       varchar2(20)      ,/* 資料所有者 */
mreaowndp       varchar2(10)      ,/* 資料所屬部門 */
mreacrtid       varchar2(20)      ,/* 資料建立者 */
mreacrtdp       varchar2(10)      ,/* 資料建立部門 */
mreacrtdt       timestamp(0)      ,/* 資料創建日 */
mreamodid       varchar2(20)      ,/* 資料修改者 */
mreamoddt       timestamp(0)      ,/* 最近修改日 */
mreacnfid       varchar2(20)      ,/* 資料確認者 */
mreacnfdt       timestamp(0)      ,/* 資料確認日 */
mreapstid       varchar2(20)      ,/* 資料過帳者 */
mreapstdt       timestamp(0)      ,/* 資料過帳日 */
mreastus       varchar2(10)      ,/* 狀態碼 */
mreaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mreaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mreaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mreaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mreaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mreaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mreaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mreaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mreaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mreaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mreaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mreaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mreaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mreaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mreaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mreaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mreaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mreaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mreaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mreaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mreaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mreaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mreaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mreaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mreaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mreaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mreaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mreaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mreaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mreaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrea_t add constraint mrea_pk primary key (mreaent,mreadocno) enable validate;

create unique index mrea_pk on mrea_t (mreaent,mreadocno);

grant select on mrea_t to tiptop;
grant update on mrea_t to tiptop;
grant delete on mrea_t to tiptop;
grant insert on mrea_t to tiptop;

exit;
