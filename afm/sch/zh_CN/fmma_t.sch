/* 
================================================================================
檔案代號:fmma_t
檔案名稱:投資類型檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table fmma_t
(
fmmaent       number(5)      ,/* 企業編號 */
fmma001       varchar2(10)      ,/* 投資類型 */
fmma002       varchar2(1)      ,/* 計息方式 */
fmma003       varchar2(1)      ,/* 投資費用處理方式 */
fmma004       varchar2(1)      ,/* 期末計量方式 */
fmmaownid       varchar2(20)      ,/* 資料所有者 */
fmmaowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmacrtid       varchar2(20)      ,/* 資料建立者 */
fmmacrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmacrtdt       timestamp(0)      ,/* 資料創建日 */
fmmamodid       varchar2(20)      ,/* 資料修改者 */
fmmamoddt       timestamp(0)      ,/* 最近修改日 */
fmmastus       varchar2(10)      ,/* 狀態碼 */
fmmaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmma005       varchar2(1)      /* 平倉出售時採用購買時匯率 */
);
alter table fmma_t add constraint fmma_pk primary key (fmmaent,fmma001) enable validate;

create unique index fmma_pk on fmma_t (fmmaent,fmma001);

grant select on fmma_t to tiptop;
grant update on fmma_t to tiptop;
grant delete on fmma_t to tiptop;
grant insert on fmma_t to tiptop;

exit;
