/* 
================================================================================
檔案代號:fmad_t
檔案名稱:融資合約明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmad_t
(
fmadent       number(5)      ,/* 企業代碼 */
fmad001       varchar2(20)      ,/* 融資合約編號 */
fmad002       number(10,0)      ,/* 項次 */
fmad003       varchar2(10)      ,/* 幣別 */
fmad004       number(10,0)      ,/* 核准額度 */
fmad005       varchar2(1)      ,/* 利率方式 */
fmad006       varchar2(1)      ,/* 浮動方式 */
fmad007       number(10,6)      ,/* 固定利率/浮動利率 */
fmad008       number(20,10)      ,/* 約定匯率 */
fmad009       varchar2(1)      ,/* 複利計算 */
fmadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmad_t add constraint fmad_pk primary key (fmadent,fmad001,fmad002) enable validate;

create unique index fmad_pk on fmad_t (fmadent,fmad001,fmad002);

grant select on fmad_t to tiptop;
grant update on fmad_t to tiptop;
grant delete on fmad_t to tiptop;
grant insert on fmad_t to tiptop;

exit;
