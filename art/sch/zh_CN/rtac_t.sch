/* 
================================================================================
檔案代號:rtac_t
檔案名稱:品類策略主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table rtac_t
(
rtacent       number(5)      ,/* 企業編號 */
rtac001       varchar2(10)      ,/* 策略編號 */
rtac002       varchar2(10)      ,/* 店群編號 */
rtac003       number(5,0)      ,/* 品類層級 */
rtac004       varchar2(10)      ,/* no use */
rtacownid       varchar2(20)      ,/* 資料所有者 */
rtacowndp       varchar2(10)      ,/* 資料所屬部門 */
rtaccrtid       varchar2(20)      ,/* 資料建立者 */
rtaccrtdp       varchar2(10)      ,/* 資料建立部門 */
rtaccrtdt       timestamp(0)      ,/* 資料創建日 */
rtacmodid       varchar2(20)      ,/* 資料修改者 */
rtacmoddt       timestamp(0)      ,/* 最近修改日 */
rtaccnfid       varchar2(20)      ,/* 資料確認者 */
rtaccnfdt       timestamp(0)      ,/* 資料確認日 */
rtacstus       varchar2(10)      ,/* 狀態碼 */
rtacud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtacud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtacud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtacud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtacud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtacud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtacud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtacud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtacud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtacud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtacud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtacud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtacud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtacud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtacud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtacud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtacud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtacud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtacud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtacud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtacud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtacud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtacud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtacud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtacud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtacud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtacud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtacud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtacud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtacud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtacunit       varchar2(10)      /* 應用組織 */
);
alter table rtac_t add constraint rtac_pk primary key (rtacent,rtac001) enable validate;

create unique index rtac_pk on rtac_t (rtacent,rtac001);

grant select on rtac_t to tiptop;
grant update on rtac_t to tiptop;
grant delete on rtac_t to tiptop;
grant insert on rtac_t to tiptop;

exit;
