/* 
================================================================================
檔案代號:fmcp_t
檔案名稱:融資擔保明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table fmcp_t
(
fmcpent       number(5)      ,/* 企業代碼 */
fmcpdocno       varchar2(20)      ,/* 融資合同編號 */
fmcpseq       number(10,0)      ,/* 清單項次 */
fmcpseq2       number(10,0)      ,/* 項次 */
fmcp001       varchar2(20)      ,/* 擔保合同編號 */
fmcp002       varchar2(10)      ,/* 擔保人 */
fmcp003       varchar2(1)      ,/* 抵押物/質押物性質 */
fmcp017       varchar2(10)      ,/* 生成批號 */
fmcp016       varchar2(10)      ,/* 卡片編號 */
fmcp004       varchar2(40)      ,/* 財產編號/料號 */
fmcp005       varchar2(20)      ,/* 附號 */
fmcp018       varchar2(30)      ,/* 成本域 */
fmcp019       varchar2(256)      ,/* 特徵碼 */
fmcp020       varchar2(30)      ,/* 批號 */
fmcp006       varchar2(10)      ,/* 單位 */
fmcp007       varchar2(20)      ,/* 權力證書編號(始) */
fmcp008       varchar2(20)      ,/* 權力證書編號(止) */
fmcp009       number(20,6)      ,/* 數量 */
fmcp010       number(20,6)      ,/* 帳面價值 */
fmcp011       number(20,6)      ,/* 合同公允價值 */
fmcp012       varchar2(1)      ,/* 狀態 */
fmcp013       varchar2(20)      ,/* 庫存留置單號 */
fmcp014       varchar2(20)      ,/* 庫存解除留置單號 */
fmcp015       varchar2(1)      ,/* 擔保方式 */
fmcpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmcpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmcpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmcpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmcpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmcpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmcpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmcpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmcpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmcpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmcpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmcpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmcpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmcpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmcpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmcpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmcpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmcpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmcpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmcpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmcpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmcpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmcpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmcpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmcpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmcpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmcpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmcpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmcpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmcpud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmcp021       varchar2(10)      ,/* 账面币别 */
fmcp022       varchar2(10)      /* 公允价值币别 */
);
alter table fmcp_t add constraint fmcp_pk primary key (fmcpent,fmcpdocno,fmcpseq,fmcpseq2) enable validate;

create unique index fmcp_pk on fmcp_t (fmcpent,fmcpdocno,fmcpseq,fmcpseq2);

grant select on fmcp_t to tiptop;
grant update on fmcp_t to tiptop;
grant delete on fmcp_t to tiptop;
grant insert on fmcp_t to tiptop;

exit;
