/* 
================================================================================
檔案代號:pcbf_t
檔案名稱:觸屏分類對應最尾階觸屏分類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcbf_t
(
pcbfent       number(5)      ,/* 企業編號 */
pcbf001       varchar2(10)      ,/* 觸屏分類編號 */
pcbf002       number(5,0)      ,/* 觸屏分類層級 */
pcbf003       varchar2(10)      ,/* 最尾階觸屏分類編號 */
pcbfownid       varchar2(20)      ,/* 資料所有者 */
pcbfowndp       varchar2(10)      ,/* 資料所屬部門 */
pcbfcrtid       varchar2(20)      ,/* 資料建立者 */
pcbfcrtdp       varchar2(10)      ,/* 資料建立部門 */
pcbfcrtdt       timestamp(0)      ,/* 資料創建日 */
pcbfmodid       varchar2(20)      ,/* 資料修改者 */
pcbfmoddt       timestamp(0)      ,/* 最近修改日 */
pcbfstus       varchar2(10)      ,/* 狀態碼 */
pcbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcbf_t add constraint pcbf_pk primary key (pcbfent,pcbf001,pcbf003) enable validate;

create unique index pcbf_pk on pcbf_t (pcbfent,pcbf001,pcbf003);

grant select on pcbf_t to tiptop;
grant update on pcbf_t to tiptop;
grant delete on pcbf_t to tiptop;
grant insert on pcbf_t to tiptop;

exit;
