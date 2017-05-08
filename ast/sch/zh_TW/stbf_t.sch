/* 
================================================================================
檔案代號:stbf_t
檔案名稱:結算單發票明細資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stbf_t
(
stbfent       number(5)      ,/* 企業編號 */
stbfsite       varchar2(10)      ,/* 所屬組織 */
stbfcomp       varchar2(10)      ,/* 所屬法人 */
stbfdocno       varchar2(20)      ,/* 單據編號 */
stbfseq       number(10,0)      ,/* 單據項次 */
stbf001       varchar2(20)      ,/* 發票代碼 */
stbf002       varchar2(20)      ,/* 發票號碼 */
stbf003       date      ,/* 發票日期 */
stbf004       varchar2(10)      ,/* 稅別 */
stbf005       number(5,2)      ,/* 稅率 */
stbf006       number(20,6)      ,/* 未稅金額 */
stbf007       number(20,6)      ,/* 稅額 */
stbf008       number(20,6)      ,/* 含稅金額 */
stbf009       varchar2(10)      ,/* 幣別 */
stbf010       number(20,10)      ,/* 匯率 */
stbf011       varchar2(10)      ,/* 廠商編號 */
stbf012       varchar2(1)      ,/* 已認證否 */
stbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stbf_t add constraint stbf_pk primary key (stbfent,stbfdocno,stbfseq) enable validate;

create unique index stbf_pk on stbf_t (stbfent,stbfdocno,stbfseq);

grant select on stbf_t to tiptop;
grant update on stbf_t to tiptop;
grant delete on stbf_t to tiptop;
grant insert on stbf_t to tiptop;

exit;
