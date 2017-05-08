/* 
================================================================================
檔案代號:bxge_t
檔案名稱:銷售,報廢,外運折合資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxge_t
(
bxgeent       number(5)      ,/* 企業編號 */
bxgesite       varchar2(10)      ,/* 營運據點 */
bxge000       varchar2(1)      ,/* 類別 */
bxge001       varchar2(40)      ,/* 主件料號 */
bxge002       date      ,/* 生效日期 */
bxge003       number(10,0)      ,/* 序號 */
bxge004       number(5,0)      ,/* 年度 */
bxge005       varchar2(40)      ,/* 料件編號 */
bxge006       number(20,6)      ,/* 組成用量 */
bxge007       number(20,6)      ,/* 折合數量(庫存單位) */
bxgeownid       varchar2(20)      ,/* 資料所有者 */
bxgeowndp       varchar2(10)      ,/* 資料所屬部門 */
bxgecrtid       varchar2(20)      ,/* 資料建立者 */
bxgecrtdp       varchar2(10)      ,/* 資料建立部門 */
bxgecrtdt       timestamp(0)      ,/* 資料創建日 */
bxgemodid       varchar2(20)      ,/* 資料修改者 */
bxgemoddt       timestamp(0)      ,/* 最近修改日 */
bxgecnfid       varchar2(20)      ,/* 資料確認者 */
bxgecnfdt       timestamp(0)      ,/* 資料確認日 */
bxgestus       varchar2(10)      ,/* 狀態碼 */
bxgeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxgeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxgeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxgeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxgeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxgeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxgeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxgeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxgeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxgeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxgeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxgeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxgeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxgeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxgeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxgeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxgeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxgeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxgeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxgeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxgeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxgeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxgeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxgeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxgeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxgeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxgeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxgeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxgeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxgeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxge_t add constraint bxge_pk primary key (bxgeent,bxgesite,bxge000,bxge001,bxge002,bxge003,bxge004) enable validate;

create unique index bxge_pk on bxge_t (bxgeent,bxgesite,bxge000,bxge001,bxge002,bxge003,bxge004);

grant select on bxge_t to tiptop;
grant update on bxge_t to tiptop;
grant delete on bxge_t to tiptop;
grant insert on bxge_t to tiptop;

exit;
