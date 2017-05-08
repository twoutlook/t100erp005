/* 
================================================================================
檔案代號:inpt_t
檔案名稱:盤點限定工單單別檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inpt_t
(
inptent       number(5)      ,/* 企業代碼 */
inptsite       varchar2(10)      ,/* 營運據點 */
inptdocno       varchar2(20)      ,/* 單號 */
inptseq       number(10,0)      ,/* 項次 */
inpt001       varchar2(20)      ,/* 單別 */
inpt002       varchar2(255)      ,/* 備註 */
inptud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inptud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inptud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inptud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inptud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inptud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inptud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inptud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inptud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inptud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inptud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inptud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inptud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inptud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inptud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inptud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inptud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inptud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inptud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inptud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inptud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inptud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inptud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inptud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inptud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inptud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inptud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inptud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inptud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inptud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpt_t add constraint inpt_pk primary key (inptent,inptdocno,inptseq) enable validate;

create unique index inpt_pk on inpt_t (inptent,inptdocno,inptseq);

grant select on inpt_t to tiptop;
grant update on inpt_t to tiptop;
grant delete on inpt_t to tiptop;
grant insert on inpt_t to tiptop;

exit;
