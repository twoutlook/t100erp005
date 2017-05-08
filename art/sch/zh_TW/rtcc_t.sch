/* 
================================================================================
檔案代號:rtcc_t
檔案名稱:預算每日係數設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtcc_t
(
rtccent       number(5)      ,/* 企業編號 */
rtccunit       varchar2(10)      ,/* 應用組織 */
rtcc001       number(10,0)      ,/* 預算期別 */
rtcc002       varchar2(10)      ,/* 行類型 */
rtcc003       varchar2(500)      ,/* 1 */
rtcc004       varchar2(500)      ,/* 2 */
rtcc005       varchar2(500)      ,/* 3 */
rtcc006       varchar2(500)      ,/* 4 */
rtcc007       varchar2(500)      ,/* 5 */
rtcc008       varchar2(500)      ,/* 6 */
rtcc009       varchar2(500)      ,/* 7 */
rtcc010       varchar2(500)      ,/* 8 */
rtcc011       varchar2(500)      ,/* 9 */
rtcc012       varchar2(500)      ,/* 10 */
rtcc013       varchar2(500)      ,/* 11 */
rtcc014       varchar2(500)      ,/* 12 */
rtcc015       varchar2(500)      ,/* 13 */
rtcc016       varchar2(500)      ,/* 14 */
rtcc017       varchar2(500)      ,/* 15 */
rtcc018       varchar2(500)      ,/* 16 */
rtcc019       varchar2(500)      ,/* 17 */
rtcc020       varchar2(500)      ,/* 18 */
rtcc021       varchar2(500)      ,/* 19 */
rtcc022       varchar2(500)      ,/* 20 */
rtcc023       varchar2(500)      ,/* 21 */
rtcc024       varchar2(500)      ,/* 22 */
rtcc025       varchar2(500)      ,/* 23 */
rtcc026       varchar2(500)      ,/* 24 */
rtcc027       varchar2(500)      ,/* 25 */
rtcc028       varchar2(500)      ,/* 26 */
rtcc029       varchar2(500)      ,/* 27 */
rtcc030       varchar2(500)      ,/* 28 */
rtcc031       varchar2(500)      ,/* 29 */
rtcc032       varchar2(500)      ,/* 30 */
rtcc033       varchar2(500)      ,/* 31 */
rtccownid       varchar2(20)      ,/* 資料所有者 */
rtccowndp       varchar2(10)      ,/* 資料所屬部門 */
rtcccrtid       varchar2(20)      ,/* 資料建立者 */
rtcccrtdp       varchar2(10)      ,/* 資料建立部門 */
rtcccrtdt       timestamp(0)      ,/* 資料創建日 */
rtccmodid       varchar2(20)      ,/* 資料修改者 */
rtccmoddt       timestamp(0)      ,/* 最近修改日 */
rtccstus       varchar2(10)      ,/* 狀態碼 */
rtccud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtccud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtccud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtccud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtccud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtccud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtccud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtccud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtccud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtccud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtccud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtccud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtccud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtccud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtccud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtccud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtccud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtccud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtccud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtccud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtccud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtccud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtccud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtccud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtccud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtccud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtccud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtccud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtccud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtccud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtcc_t add constraint rtcc_pk primary key (rtccent,rtcc001,rtcc002) enable validate;

create unique index rtcc_pk on rtcc_t (rtccent,rtcc001,rtcc002);

grant select on rtcc_t to tiptop;
grant update on rtcc_t to tiptop;
grant delete on rtcc_t to tiptop;
grant insert on rtcc_t to tiptop;

exit;
