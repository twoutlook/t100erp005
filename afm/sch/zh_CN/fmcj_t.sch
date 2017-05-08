/* 
================================================================================
檔案代號:fmcj_t
檔案名稱:融資合同單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmcj_t
(
fmcjent       number(5)      ,/* 企業代碼 */
fmcjownid       varchar2(20)      ,/* 資料所屬者 */
fmcjowndp       varchar2(10)      ,/* 資料所屬部門 */
fmcjcrtid       varchar2(20)      ,/* 資料建立者 */
fmcjcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmcjcrtdt       timestamp(0)      ,/* 資料創建日 */
fmcjmodid       varchar2(20)      ,/* 資料修改者 */
fmcjmoddt       timestamp(0)      ,/* 最近修改日 */
fmcjcnfid       varchar2(20)      ,/* 資料確認者 */
fmcjcnfdt       timestamp(0)      ,/* 資料確認日 */
fmcjstus       varchar2(10)      ,/* 狀態碼 */
fmcjdocno       varchar2(20)      ,/* 融資合同編號 */
fmcjsite       varchar2(10)      ,/* 融資組織 */
fmcjcomp       varchar2(10)      ,/* 法人 */
fmcjdocdt       date      ,/* 簽訂日期 */
fmcj001       varchar2(10)      ,/* 融資類型 */
fmcj002       varchar2(15)      ,/* 貸款銀行 */
fmcj003       varchar2(20)      ,/* 銀行貸款合同編號 */
fmcj004       varchar2(20)      ,/* 合約編號 */
fmcj005       varchar2(1)      ,/* 擔保方式 */
fmcj006       date      ,/* 貸款期限起 */
fmcj007       date      ,/* 貸款期限止 */
fmcj008       varchar2(1)      ,/* 不定日分次劃付 */
fmcj009       number(5,0)      ,/* 計息基礎 */
fmcjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmcj_t add constraint fmcj_pk primary key (fmcjent,fmcjdocno) enable validate;

create unique index fmcj_pk on fmcj_t (fmcjent,fmcjdocno);

grant select on fmcj_t to tiptop;
grant update on fmcj_t to tiptop;
grant delete on fmcj_t to tiptop;
grant insert on fmcj_t to tiptop;

exit;
