/* 
================================================================================
檔案代號:rtkc_t
檔案名稱:自動補貨年節日設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table rtkc_t
(
rtkcent       number(5)      ,/* 企業編號 */
rtkcunit       varchar2(10)      ,/* 應用組織 */
rtkc001       varchar2(1)      ,/* 資料類型 */
rtkc002       varchar2(10)      ,/* 店群門店編號 */
rtkc003       number(10,0)      ,/* 項次 */
rtkc004       date      ,/* 計算起始日 */
rtkc005       date      ,/* 計算起始日 */
rtkc006       number(5,0)      ,/* 補貨年節日天數 */
rtkc007       varchar2(255)      ,/* 備註 */
rtkcownid       varchar2(20)      ,/* 資料所有者 */
rtkcowndp       varchar2(10)      ,/* 資料所屬部門 */
rtkccrtid       varchar2(20)      ,/* 資料建立者 */
rtkccrtdp       varchar2(10)      ,/* 資料建立部門 */
rtkccrtdt       timestamp(0)      ,/* 資料創建日 */
rtkcmodid       varchar2(20)      ,/* 資料修改者 */
rtkcmoddt       timestamp(0)      ,/* 最近修改日 */
rtkcstus       varchar2(10)      ,/* 狀態碼 */
rtkcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtkcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtkcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtkcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtkcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtkcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtkcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtkcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtkcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtkcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtkcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtkcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtkcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtkcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtkcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtkcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtkcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtkcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtkcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtkcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtkcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtkcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtkcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtkcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtkcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtkcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtkcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtkcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtkcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtkcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtkc_t add constraint rtkc_pk primary key (rtkcent,rtkc001,rtkc002,rtkc003) enable validate;

create unique index rtkc_pk on rtkc_t (rtkcent,rtkc001,rtkc002,rtkc003);

grant select on rtkc_t to tiptop;
grant update on rtkc_t to tiptop;
grant delete on rtkc_t to tiptop;
grant insert on rtkc_t to tiptop;

exit;
