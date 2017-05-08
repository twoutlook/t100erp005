/* 
================================================================================
檔案代號:rtdr_t
檔案名稱:自有商品引進單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtdr_t
(
rtdrent       number(5)      ,/* 企業編號 */
rtdrdocno       varchar2(20)      ,/* 單據編號 */
rtdrdocdt       date      ,/* 單據日期 */
rtdr001       varchar2(10)      ,/* 配送中心 */
rtdr002       varchar2(10)      ,/* 店群 */
rtdr003       varchar2(10)      ,/* 生命週期 */
rtdr004       varchar2(255)      ,/* 備註 */
rtdrstus       varchar2(10)      ,/* 狀態碼 */
rtdrownid       varchar2(20)      ,/* 資料所有者 */
rtdrowndp       varchar2(10)      ,/* 資料所有部門 */
rtdrcrtid       varchar2(20)      ,/* 資料建立者 */
rtdrcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtdrcrtdt       timestamp(0)      ,/* 資料創建日 */
rtdrmodid       varchar2(20)      ,/* 資料修改者 */
rtdrmoddt       timestamp(0)      ,/* 最近修改日 */
rtdrcnfid       varchar2(20)      ,/* 資料確認者 */
rtdrcnfdt       timestamp(0)      ,/* 資料確認日 */
rtdrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdrud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtdrsite       varchar2(10)      ,/* 營運據點 */
rtdrunit       varchar2(10)      ,/* 應用組織 */
rtdr005       varchar2(10)      ,/* 稅區別 */
rtdr000       varchar2(10)      /* 作業方式 */
);
alter table rtdr_t add constraint rtdr_pk primary key (rtdrent,rtdrdocno) enable validate;

create unique index rtdr_pk on rtdr_t (rtdrent,rtdrdocno);

grant select on rtdr_t to tiptop;
grant update on rtdr_t to tiptop;
grant delete on rtdr_t to tiptop;
grant insert on rtdr_t to tiptop;

exit;
