/* 
================================================================================
檔案代號:mrbh_t
檔案名稱:資源行事曆檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mrbh_t
(
mrbhent       number(5)      ,/* 企業編號 */
mrbhsite       varchar2(10)      ,/* 營運據點 */
mrbh001       varchar2(20)      ,/* 資源編號 */
mrbh002       date      ,/* 日期 */
mrbh003       varchar2(8)      ,/* 開始時間 */
mrbh004       varchar2(8)      ,/* 結束時間 */
mrbh005       varchar2(1)      ,/* 正常運作否 */
mrbh006       varchar2(10)      ,/* 工作站 */
mrbh007       varchar2(10)      ,/* 保修項目 */
mrbh008       varchar2(255)      ,/* 備註 */
mrbhownid       varchar2(20)      ,/* 資料所有者 */
mrbhowndp       varchar2(10)      ,/* 資料所屬部門 */
mrbhcrtid       varchar2(20)      ,/* 資料建立者 */
mrbhcrtdp       varchar2(10)      ,/* 資料建立部門 */
mrbhcrtdt       timestamp(0)      ,/* 資料創建日 */
mrbhmodid       varchar2(20)      ,/* 資料修改者 */
mrbhmoddt       timestamp(0)      ,/* 最近修改日 */
mrbhcnfid       varchar2(20)      ,/* 資料確認者 */
mrbhcnfdt       timestamp(0)      ,/* 資料確認日 */
mrbhstus       varchar2(10)      ,/* 狀態碼 */
mrbhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrbhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrbhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrbhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrbhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrbhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrbhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrbhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrbhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrbhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrbhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrbhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrbhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrbhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrbhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrbhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrbhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrbhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrbhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrbhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrbhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrbhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrbhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrbhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrbhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrbhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrbhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrbhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrbhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrbhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrbh_t add constraint mrbh_pk primary key (mrbhent,mrbhsite,mrbh001,mrbh002,mrbh003,mrbh007) enable validate;

create unique index mrbh_pk on mrbh_t (mrbhent,mrbhsite,mrbh001,mrbh002,mrbh003,mrbh007);

grant select on mrbh_t to tiptop;
grant update on mrbh_t to tiptop;
grant delete on mrbh_t to tiptop;
grant insert on mrbh_t to tiptop;

exit;
