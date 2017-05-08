/* 
================================================================================
檔案代號:pcaf_t
檔案名稱:POS角色基本資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcaf_t
(
pcafent       number(5)      ,/* 企業編號 */
pcafunit       varchar2(10)      ,/* 應用組織 */
pcaf001       varchar2(10)      ,/* 角色編號 */
pcaf002       number(20,6)      ,/* 折扣 */
pcafstamp       timestamp(5)      ,/* 時間戳記 */
pcafstus       varchar2(10)      ,/* 狀態碼 */
pcafownid       varchar2(20)      ,/* 資料所有者 */
pcafowndp       varchar2(10)      ,/* 資料所屬部門 */
pcafcrtid       varchar2(20)      ,/* 資料建立者 */
pcafcrtdp       varchar2(10)      ,/* 資料建立部門 */
pcafcrtdt       timestamp(0)      ,/* 資料創建日 */
pcafmodid       varchar2(20)      ,/* 資料修改者 */
pcafmoddt       timestamp(0)      ,/* 最近修改日 */
pcafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcaf_t add constraint pcaf_pk primary key (pcafent,pcaf001) enable validate;

create unique index pcaf_pk on pcaf_t (pcafent,pcaf001);

grant select on pcaf_t to tiptop;
grant update on pcaf_t to tiptop;
grant delete on pcaf_t to tiptop;
grant insert on pcaf_t to tiptop;

exit;
