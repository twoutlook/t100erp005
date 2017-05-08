/* 
================================================================================
檔案代號:mhbe_t
檔案名稱:鋪位資料主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mhbe_t
(
mhbeent       number(5)      ,/* 企業編號 */
mhbesite       varchar2(10)      ,/* 營運組織 */
mhbeunit       varchar2(10)      ,/* 應用組織 */
mhbe001       varchar2(20)      ,/* 鋪位編號 */
mhbe002       number(5,0)      ,/* 鋪位版本 */
mhbe003       varchar2(10)      ,/* 樓棟編號 */
mhbe004       varchar2(10)      ,/* 樓層編號 */
mhbe005       varchar2(10)      ,/* 區域編號 */
mhbe006       number(20,6)      ,/* 建築面積 */
mhbe007       number(20,6)      ,/* 測量面積 */
mhbe008       number(20,6)      ,/* 經營面積 */
mhbe009       varchar2(10)      ,/* 管理品類 */
mhbe010       varchar2(10)      ,/* 鋪位用途 */
mhbe011       varchar2(255)      ,/* 門牌號 */
mhbe012       varchar2(10)      ,/* 鋪位狀態 */
mhbe015       varchar2(80)      ,/* 備註 */
mhbe017       varchar2(10)      ,/* 鋪位等級 */
mhbestus       varchar2(10)      ,/* 狀態碼 */
mhbeownid       varchar2(20)      ,/* 資料所有者 */
mhbeowndp       varchar2(10)      ,/* 資料所屬部門 */
mhbecrtid       varchar2(20)      ,/* 資料建立者 */
mhbecrtdp       varchar2(10)      ,/* 資料建立部門 */
mhbecrtdt       timestamp(0)      ,/* 資料創建日 */
mhbemodid       varchar2(20)      ,/* 資料修改者 */
mhbemoddt       timestamp(0)      ,/* 最近修改日 */
mhbecnfid       varchar2(20)      ,/* 資料確認者 */
mhbecnfdt       timestamp(0)      ,/* 資料確認日 */
mhbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mhbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mhbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mhbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mhbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mhbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mhbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mhbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mhbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mhbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mhbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mhbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mhbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mhbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mhbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mhbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mhbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mhbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mhbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mhbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mhbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mhbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mhbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mhbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mhbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mhbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mhbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mhbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mhbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mhbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mhbe_t add constraint mhbe_pk primary key (mhbeent,mhbe001) enable validate;

create unique index mhbe_pk on mhbe_t (mhbeent,mhbe001);

grant select on mhbe_t to tiptop;
grant update on mhbe_t to tiptop;
grant delete on mhbe_t to tiptop;
grant insert on mhbe_t to tiptop;

exit;
