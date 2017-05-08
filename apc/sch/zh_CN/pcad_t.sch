/* 
================================================================================
檔案代號:pcad_t
檔案名稱:POS模組基本資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pcad_t
(
pcadent       number(5)      ,/* 企業編號 */
pcadunit       varchar2(10)      ,/* 應用組織 */
pcad001       varchar2(40)      ,/* 模塊編號 */
pcad002       varchar2(10)      ,/* 模塊等級 */
pcad003       varchar2(40)      ,/* 上級模塊 */
pcad004       varchar2(10)      ,/* 功能類型 */
pcad005       varchar2(40)      ,/* 程序名稱 */
pcad006       varchar2(40)      ,/* 參數 */
pcad007       varchar2(1)      ,/* 是否打印 */
pcad008       varchar2(1)      ,/* 是否客顯 */
pcadstamp       timestamp(5)      ,/* 時間戳記 */
pcadstus       varchar2(10)      ,/* 狀態碼 */
pcadownid       varchar2(20)      ,/* 資料所有者 */
pcadowndp       varchar2(10)      ,/* 資料所屬部門 */
pcadcrtid       varchar2(20)      ,/* 資料建立者 */
pcadcrtdp       varchar2(10)      ,/* 資料建立部門 */
pcadcrtdt       timestamp(0)      ,/* 資料創建日 */
pcadmodid       varchar2(20)      ,/* 資料修改者 */
pcadmoddt       timestamp(0)      ,/* 最近修改日 */
pcadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pcadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pcadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pcadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pcadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pcadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pcadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pcadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pcadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pcadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pcadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pcadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pcadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pcadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pcadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pcadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pcadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pcadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pcadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pcadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pcadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pcadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pcadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pcadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pcadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pcadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pcadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pcadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pcadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pcadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pcad_t add constraint pcad_pk primary key (pcadent,pcad001) enable validate;

create unique index pcad_pk on pcad_t (pcadent,pcad001);

grant select on pcad_t to tiptop;
grant update on pcad_t to tiptop;
grant delete on pcad_t to tiptop;
grant insert on pcad_t to tiptop;

exit;
