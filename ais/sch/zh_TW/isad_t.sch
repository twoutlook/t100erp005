/* 
================================================================================
檔案代號:isad_t
檔案名稱:發票字軌資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table isad_t
(
isadent       number(5)      ,/* 企業編號 */
isadownid       varchar2(20)      ,/* 資料所有者 */
isadowndp       varchar2(10)      ,/* 資料所屬部門 */
isadcrtid       varchar2(20)      ,/* 資料建立者 */
isadcrtdp       varchar2(10)      ,/* 資料建立部門 */
isadcrtdt       timestamp(0)      ,/* 資料創建日 */
isadmodid       varchar2(20)      ,/* 資料修改者 */
isadmoddt       timestamp(0)      ,/* 最近修改日 */
isadstus       varchar2(10)      ,/* 狀態碼 */
isad001       varchar2(10)      ,/* 交易稅區 */
isad002       number(5,0)      ,/* 年度 */
isad003       number(5,0)      ,/* 起始月份 */
isad004       number(5,0)      ,/* 終止月份 */
isad005       varchar2(20)      ,/* 發票字軌 */
isad006       varchar2(1)      ,/* 發票種類 */
isadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isad_t add constraint isad_pk primary key (isadent,isad001,isad002,isad003,isad004,isad005) enable validate;

create unique index isad_pk on isad_t (isadent,isad001,isad002,isad003,isad004,isad005);

grant select on isad_t to tiptop;
grant update on isad_t to tiptop;
grant delete on isad_t to tiptop;
grant insert on isad_t to tiptop;

exit;
