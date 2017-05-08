/* 
================================================================================
檔案代號:rtei_t
檔案名稱:庫區商品對應關係檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtei_t
(
rteient       number(5)      ,/* 企業編號 */
rteisite       varchar2(10)      ,/* 營運據點 */
rteiunit       varchar2(10)      ,/* 應用組織 */
rtei001       varchar2(10)      ,/* 庫區編號 */
rtei002       varchar2(40)      ,/* 商品編號 */
rtei003       varchar2(40)      ,/* 商品主條碼 */
rtei004       varchar2(10)      ,/* 專櫃編號 */
rtei005       varchar2(1)      ,/* 可售 */
rteiacti       varchar2(1)      ,/* 有效 */
rteistamp       timestamp(5)      ,/* 下傳時間戳記 */
rteiownid       varchar2(20)      ,/* 資料所有者 */
rteiowndp       varchar2(10)      ,/* 資料所屬部門 */
rteicrtid       varchar2(20)      ,/* 資料建立者 */
rteicrtdp       varchar2(10)      ,/* 資料建立部門 */
rteicrtdt       timestamp(0)      ,/* 資料創建日 */
rteimodid       varchar2(20)      ,/* 資料修改者 */
rteimoddt       timestamp(0)      ,/* 最近修改日 */
rteiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rteiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rteiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rteiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rteiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rteiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rteiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rteiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rteiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rteiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rteiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rteiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rteiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rteiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rteiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rteiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rteiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rteiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rteiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rteiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rteiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rteiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rteiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rteiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rteiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rteiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rteiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rteiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rteiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rteiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtei_t add constraint rtei_pk primary key (rteient,rtei001,rtei002) enable validate;

create unique index rtei_pk on rtei_t (rteient,rtei001,rtei002);

grant select on rtei_t to tiptop;
grant update on rtei_t to tiptop;
grant delete on rtei_t to tiptop;
grant insert on rtei_t to tiptop;

exit;
