/* 
================================================================================
檔案代號:oogc_t
檔案名稱:行事曆檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oogc_t
(
oogcent       number(5)      ,/* 企業編號 */
oogcstus       varchar2(10)      ,/* 狀態碼 */
oogc001       varchar2(5)      ,/* 行事曆參照表號 */
oogc002       varchar2(10)      ,/* 行事曆類別 */
oogc003       date      ,/* 日期 */
oogc004       varchar2(10)      ,/* 休假類型 */
oogc005       varchar2(80)      ,/* 原因說明 */
oogc006       number(5,0)      ,/* 期別 */
oogc007       number(5,0)      ,/* 季別 */
oogc008       number(5,0)      ,/* 週別 */
oogc009       number(15,3)      ,/* 上班時數 */
oogc010       varchar2(10)      ,/* 分類一 */
oogc011       varchar2(10)      ,/* 分類二 */
oogc012       varchar2(10)      ,/* 分類三 */
oogc013       varchar2(10)      ,/* 分類四 */
oogc014       varchar2(10)      ,/* 分類五 */
oogc015       number(5,0)      ,/* 年度 */
oogcownid       varchar2(20)      ,/* 資料所有者 */
oogcowndp       varchar2(10)      ,/* 資料所屬部門 */
oogccrtid       varchar2(20)      ,/* 資料建立者 */
oogccrtdp       varchar2(10)      ,/* 資料建立部門 */
oogccrtdt       timestamp(0)      ,/* 資料創建日 */
oogcmodid       varchar2(20)      ,/* 資料修改者 */
oogcmoddt       timestamp(0)      ,/* 最近修改日 */
oogc016       number(5,0)      ,/* 月份 */
oogc017       number(5,0)      ,/* 月週 */
oogcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oogcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oogcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oogcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oogcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oogcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oogcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oogcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oogcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oogcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oogcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oogcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oogcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oogcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oogcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oogcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oogcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oogcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oogcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oogcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oogcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oogcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oogcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oogcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oogcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oogcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oogcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oogcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oogcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oogcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oogc_t add constraint oogc_pk primary key (oogcent,oogc001,oogc002,oogc003,oogc015) enable validate;

create  index oogc_001 on oogc_t (oogc006);
create  index oogc_002 on oogc_t (oogc007);
create  index oogc_003 on oogc_t (oogc008);
create  index oogc_004 on oogc_t (oogc015);
create  index oogc_005 on oogc_t (oogc016);
create  index oogc_006 on oogc_t (oogc017);
create unique index oogc_pk on oogc_t (oogcent,oogc001,oogc002,oogc003,oogc015);

grant select on oogc_t to tiptop;
grant update on oogc_t to tiptop;
grant delete on oogc_t to tiptop;
grant insert on oogc_t to tiptop;

exit;
