/* 
================================================================================
檔案代號:gzxg_t
檔案名稱:使用者定義運行作業功表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzxg_t
(
gzxgent       number(5)      ,/* 企業編號 */
gzxg001       varchar2(20)      ,/* 使用者編號 */
gzxg002       varchar2(20)      ,/* 作業編號 */
gzxgownid       varchar2(20)      ,/* 資料所有者 */
gzxgowndp       varchar2(10)      ,/* 資料所屬部門 */
gzxgcrtid       varchar2(20)      ,/* 資料建立者 */
gzxgcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzxgcrtdt       timestamp(0)      ,/* 資料創建日 */
gzxgmodid       varchar2(20)      ,/* 資料修改者 */
gzxgmoddt       timestamp(0)      ,/* 最近修改日 */
gzxgstus       varchar2(10)      ,/* 狀態碼 */
gzxgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzxg_t add constraint gzxg_pk primary key (gzxgent,gzxg001,gzxg002) enable validate;

create unique index gzxg_pk on gzxg_t (gzxgent,gzxg001,gzxg002);

grant select on gzxg_t to tiptop;
grant update on gzxg_t to tiptop;
grant delete on gzxg_t to tiptop;
grant insert on gzxg_t to tiptop;

exit;
