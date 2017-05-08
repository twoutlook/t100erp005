/* 
================================================================================
檔案代號:fmcq_t
檔案名稱:債券融資明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmcq_t
(
fmcqent       number(5)      ,/* 企業代碼 */
fmcqdocno       varchar2(20)      ,/* 融資合同編號 */
fmcqseq       number(10,0)      ,/* 清單項次 */
fmcqseq2       number(10,0)      ,/* 項次 */
fmcq001       varchar2(10)      ,/* 債券編號 */
fmcq002       varchar2(10)      ,/* 發行幣別 */
fmcq003       number(10,0)      ,/* 債券面值 */
fmcq004       number(15,3)      ,/* 票面利率 */
fmcq005       varchar2(20)      ,/* 債券編號起 */
fmcq006       varchar2(20)      ,/* 債券編號止 */
fmcq007       number(20,6)      ,/* 發行數量 */
fmcq008       number(20,6)      ,/* 債券本金總額 */
fmcq009       number(20,6)      ,/* 發行價格 */
fmcqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmcq_t add constraint fmcq_pk primary key (fmcqent,fmcqdocno,fmcqseq,fmcqseq2) enable validate;

create unique index fmcq_pk on fmcq_t (fmcqent,fmcqdocno,fmcqseq,fmcqseq2);

grant select on fmcq_t to tiptop;
grant update on fmcq_t to tiptop;
grant delete on fmcq_t to tiptop;
grant insert on fmcq_t to tiptop;

exit;
