/* 
================================================================================
檔案代號:gzom_t
檔案名稱:系統公告資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzom_t
(
gzom001       varchar2(10)      ,/* 公告編號 */
gzom002       varchar2(80)      ,/* 公告內容 */
gzom003       varchar2(20)      ,/* 發布人員 */
gzomownid       varchar2(20)      ,/* 資料所有者 */
gzomowndp       varchar2(10)      ,/* 資料所屬部門 */
gzomcrtid       varchar2(20)      ,/* 資料建立者 */
gzomcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzomcrtdt       timestamp(0)      ,/* 資料創建日 */
gzommodid       varchar2(20)      ,/* 資料修改者 */
gzommoddt       timestamp(0)      ,/* 最近修改日 */
gzomstus       varchar2(10)      ,/* 狀態碼 */
gzomud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzomud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzomud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzomud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzomud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzomud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzomud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzomud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzomud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzomud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzomud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzomud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzomud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzomud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzomud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzomud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzomud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzomud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzomud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzomud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzomud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzomud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzomud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzomud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzomud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzomud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzomud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzomud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzomud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzomud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzom_t add constraint gzom_pk primary key (gzom001) enable validate;

create unique index gzom_pk on gzom_t (gzom001);

grant select on gzom_t to tiptop;
grant update on gzom_t to tiptop;
grant delete on gzom_t to tiptop;
grant insert on gzom_t to tiptop;

exit;
