/* 
================================================================================
檔案代號:xmer_t
檔案名稱:銷售估價單位工資率檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmer_t
(
xmerent       number(5)      ,/* 企業編號 */
xmersite       varchar2(10)      ,/* 營運據點 */
xmerdocdt       date      ,/* 日期 */
xmer001       varchar2(10)      ,/* 幣別 */
xmer002       varchar2(10)      ,/* 作業編號 */
xmer003       varchar2(10)      ,/* 工作站 */
xmer004       varchar2(10)      ,/* 工資率單位 */
xmer005       number(20,6)      ,/* 單位小時工資 */
xmer006       number(20,6)      ,/* 單位小時製費 */
xmerownid       varchar2(20)      ,/* 資料所有者 */
xmerowndp       varchar2(10)      ,/* 資料所屬部門 */
xmercrtid       varchar2(20)      ,/* 資料建立者 */
xmercrtdp       varchar2(10)      ,/* 資料建立部門 */
xmercrtdt       timestamp(0)      ,/* 資料創建日 */
xmermodid       varchar2(20)      ,/* 資料修改者 */
xmermoddt       timestamp(0)      ,/* 最近修改日 */
xmerstus       varchar2(10)      ,/* 狀態碼 */
xmerud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmerud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmerud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmerud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmerud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmerud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmerud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmerud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmerud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmerud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmerud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmerud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmerud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmerud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmerud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmerud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmerud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmerud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmerud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmerud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmerud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmerud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmerud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmerud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmerud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmerud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmerud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmerud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmerud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmerud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmer_t add constraint xmer_pk primary key (xmerent,xmersite,xmerdocdt,xmer001,xmer002,xmer003) enable validate;

create unique index xmer_pk on xmer_t (xmerent,xmersite,xmerdocdt,xmer001,xmer002,xmer003);

grant select on xmer_t to tiptop;
grant update on xmer_t to tiptop;
grant delete on xmer_t to tiptop;
grant insert on xmer_t to tiptop;

exit;
